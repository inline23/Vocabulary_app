import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:vocabulary_app/hive_constants.dart';
import 'package:vocabulary_app/model/word_model.dart';

class WriteDataCubit extends Cubit<WriteDataCubitStates> {
  WriteDataCubit() : super(WriteDataCubitInitalState());
  static WriteDataCubit get(context) => BlocProvider.of(context);

  final Box _box = Hive.box(HiveConstants.wordsBox);

  String text = '';
  bool isArabic = true;
  int colorCode = 0xFF193264;

  void updateText(String text) {
    this.text = text;
  }

  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDataCubitInitalState());
  }

  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataCubitInitalState());
  }

  void addWord() {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words.add(
        WordModel(
          indexAtDatabase: words.length,
          text: text,
          isArabic: isArabic,
          colorCode: colorCode,
        ),
      );
      _box.put(HiveConstants.wordsList, words);
    });
  }

  void deleteWord(int indexAtDatabase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words.removeAt(indexAtDatabase);
      for (int i = indexAtDatabase; i < words.length; i++) {
        words[i] = words[i].decremantIndexAtDatabase();
      }
      _box.put(HiveConstants.wordsList, words);
    });
    emit(WriteDataCubitLoadingState());
  }

  void addSimilarWord(int indexAtDatabase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexAtDatabase] = words[indexAtDatabase].addSimilarWord(
        text,
        isArabic,
      );
      _box.put(HiveConstants.wordsList, words);
    });
  }

  void addExample(int indexAtDatabase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexAtDatabase] = words[indexAtDatabase].addExample(
        text,
        isArabic,
      );
      _box.put(HiveConstants.wordsList, words);
    });
  }

  void deleteSimilarWord(
    int indexAtDatabase,
    int indexAtSimilarWord,
    bool isArabicSimilarWord,
  ) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexAtDatabase] = words[indexAtDatabase].deleteSimilarWord(
        indexAtSimilarWord,
        isArabicSimilarWord,
      );
      _box.put(HiveConstants.wordsList, words);
    });
  }

  void deleteExample(
    int indexAtDatabase,
    int indexAtExamples,
    bool isExampleArabic,
  ) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexAtDatabase] = words[indexAtDatabase].deleteExample(
        indexAtExamples,
        isExampleArabic,
      );
      _box.put(HiveConstants.wordsList, words);
    });
  }

  List<WordModel> _getWordsFromDatabase() =>
      List.from(
        _box.get(HiveConstants.wordsList, defaultValue: []),
      ).cast<WordModel>();

  void _tryAndCatchBlock(VoidCallback methodToExecute) {
    emit(WriteDataCubitLoadingState());
    try {
      methodToExecute.call();
      emit(WriteDataCubitSuccessState());
    } catch (error) {
      emit(WriteDataCubitFailureState(message: error.toString()));
    }
  }
}
