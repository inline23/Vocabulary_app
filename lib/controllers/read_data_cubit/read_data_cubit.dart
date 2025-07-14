import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit_states.dart';
import 'package:vocabulary_app/hive_constants.dart';
import 'package:vocabulary_app/model/word_model.dart';

class ReadDataCubit extends Cubit<ReadDataCubitStates> {
  ReadDataCubit() : super(ReadDataCubitInitialState());

  static get(context) => BlocProvider.of(context);

  final Box _box = Hive.box(HiveConstants.wordsBox);
  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.descending;

  void updateLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
  }

  void updateSortedBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
  }

  void updateSortingType(SortingType sortingType) {
    this.sortingType = sortingType;
  }

  void getWords() {
    emit(ReadDataCubitLoadingState());
    try {
      List<WordModel> wordsToReturn =
          List.from(
            _box.get(HiveConstants.wordsList, defaultValue: []),
          ).cast<WordModel>();
      _removeUnwantedWords(wordsToReturn);
      _applySorting(wordsToReturn);
      emit(ReadDataCubitSuccessState(words: wordsToReturn));
    } catch (error) {
      emit(ReadDataCubitFailureState(message: error.toString()));
    }
  }

  void _removeUnwantedWords(List<WordModel> wordsToReturn) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (var i = 0; i < wordsToReturn.length; i++) {
      // if language filter is arabic and the word is not arabic delete it , and if language filter is english and the word is arabic delete it
      if ((languageFilter == LanguageFilter.arabicOnly &&
              wordsToReturn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              wordsToReturn[i].isArabic == true)) {
        wordsToReturn.removeAt(i);
        i--;
      }
    }
  }

  void _applySorting(List<WordModel> wordsToReturn) {
    if (sortedBy == SortedBy.time) {
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    } else {
      wordsToReturn.sort(
        (WordModel a, WordModel b) => a.text.length.compareTo(b.text.length),
      );
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    }
  }

  void _reverse(List<WordModel> wordsToReturn) {
    for (int i = 0; i < wordsToReturn.length / 2; i++) {
      WordModel temp = wordsToReturn[i];
      wordsToReturn[i] = wordsToReturn[wordsToReturn.length - 1 - i];
      wordsToReturn[wordsToReturn.length - 1 - i] = temp;
    }
  }
}

enum LanguageFilter { arabicOnly, englishOnly, allWords }

enum SortedBy { time, length }

enum SortingType { ascending, descending }
