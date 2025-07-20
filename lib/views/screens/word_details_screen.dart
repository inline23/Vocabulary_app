import 'package:flutter/material.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/model/word_model.dart';

class WordDetailsScreen extends StatelessWidget {
  const WordDetailsScreen({super.key, required this.wordModel});
  final WordModel wordModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _getAppBar(context));
  }

  AppBar _getAppBar(context) => AppBar(
    foregroundColor: Color(wordModel.colorCode),
    title: Text('Word details'),
    actions: [
      IconButton(
        onPressed: () => _deleteWord(context),
        icon: Icon(Icons.delete),
      ),
    ],
  );

  void _deleteWord(BuildContext context) {
    WriteDataCubit.get(context).deleteWord(wordModel.indexAtDatabase);
    Navigator.pop(context);
  }
}
