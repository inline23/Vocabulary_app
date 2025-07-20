import 'package:flutter/material.dart';
import 'package:vocabulary_app/model/word_model.dart';

class WordDetailsScreen extends StatelessWidget {
  const WordDetailsScreen({super.key, required this.wordModel});
  final WordModel wordModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _getAppBar());
  }

  AppBar _getAppBar() => AppBar(
    foregroundColor: Color(wordModel.colorCode),
    title: Text('Word details'),
  );
}
