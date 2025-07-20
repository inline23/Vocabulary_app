import 'package:flutter/material.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/model/word_model.dart';
import 'package:vocabulary_app/views/screens/word_details_screen.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => WordDetailsScreen(wordModel: wordModel),
              ),
            )
            .then((value) {
              ReadDataCubit.get(context).getWords();
            });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(wordModel.colorCode),
        ),
        child: Center(
          child: Text(
            wordModel.text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
