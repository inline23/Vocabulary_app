import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit_states.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/model/word_model.dart';
import 'package:vocabulary_app/views/widgets/exception_widget.dart';
import 'package:vocabulary_app/views/widgets/update_word_botton.dart';
import 'package:vocabulary_app/views/widgets/update_word_dialog.dart';
import 'package:vocabulary_app/views/widgets/word_info_widget.dart';

class WordDetailsScreen extends StatefulWidget {
  const WordDetailsScreen({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  State<WordDetailsScreen> createState() => _WordDetailsScreenState();
}

class _WordDetailsScreenState extends State<WordDetailsScreen> {
  late WordModel _wordModel;

  @override
  void initState() {
    _wordModel = widget.wordModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
          if (state is ReadDataCubitSuccessState) {
            int index = state.words.indexWhere(
              (element) =>
                  element.indexAtDatabase == _wordModel.indexAtDatabase,
            );
            _wordModel = state.words[index];
            return _getSuccessBody(context);
          }
          if (state is ReadDataCubitFailureState) {
            return ExceptionWidget(
              iconData: Icons.error,
              message: state.message,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView _getSuccessBody(BuildContext context) => ListView(
    padding: EdgeInsets.symmetric(horizontal: 10),
    children: [
      _getLabelText('Word'),
      const SizedBox(height: 5),
      WordInfoWidget(
        color: Color(_wordModel.colorCode),
        isArabic: _wordModel.isArabic,
        text: _wordModel.text,
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          _getLabelText('Similar words'),
          Spacer(),
          UpdateWordBotton(
            color: Color(_wordModel.colorCode),
            onTap:
                () => showDialog(
                  context: context,
                  builder:
                      (context) => UpdateWordDialog(
                        isExample: false,
                        colorCode: _wordModel.colorCode,
                        indexAtDatabase: _wordModel.indexAtDatabase,
                      ),
                ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      for (int i = 0; i < _wordModel.arabicSimilarWords.length; i++)
        WordInfoWidget(
          color: Color(_wordModel.colorCode),
          isArabic: true,
          text: _wordModel.arabicSimilarWords[i],
        ),
      for (int i = 0; i < _wordModel.englishSimilarWords.length; i++)
        WordInfoWidget(
          color: Color(_wordModel.colorCode),
          isArabic: false,
          text: _wordModel.englishSimilarWords[i],
        ),
      const SizedBox(height: 10),
      Row(
        children: [
          _getLabelText('Examples'),
          Spacer(),
          UpdateWordBotton(
            color: Color(_wordModel.colorCode),
            onTap:
                () => showDialog(
                  context: context,
                  builder:
                      (context) => UpdateWordDialog(
                        isExample: true,
                        colorCode: _wordModel.colorCode,
                        indexAtDatabase: _wordModel.indexAtDatabase,
                      ),
                ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      for (int i = 0; i < _wordModel.arabicExamples.length; i++)
        WordInfoWidget(
          color: Color(_wordModel.colorCode),
          isArabic: true,
          text: _wordModel.arabicExamples[i],
        ),
      for (int i = 0; i < _wordModel.englishExamples.length; i++)
        WordInfoWidget(
          color: Color(_wordModel.colorCode),
          isArabic: false,
          text: _wordModel.englishExamples[i],
        ),
    ],
  );

  AppBar _getAppBar(context) => AppBar(
    foregroundColor: Color(widget.wordModel.colorCode),
    backgroundColor: Colors.transparent,
    title: Text(
      'Word details',
      style: TextStyle(color: Color(widget.wordModel.colorCode)),
    ),
    actions: [
      IconButton(
        onPressed: () => _deleteWord(context),
        icon: Icon(Icons.delete),
      ),
    ],
  );

  void _deleteWord(BuildContext context) {
    WriteDataCubit.get(context).deleteWord(widget.wordModel.indexAtDatabase);
    Navigator.pop(context);
  }

  _getLabelText(String label) => Text(
    label,
    style: TextStyle(
      color: Color(widget.wordModel.colorCode),
      fontSize: 21,
      fontWeight: FontWeight.bold,
    ),
  );
}
