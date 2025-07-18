import 'package:flutter/material.dart';
import 'package:vocabulary_app/model/word_model.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.word});
  final WordModel word;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(word.colorCode),
      ),
      child: Center(
        child: Text(
          word.text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
