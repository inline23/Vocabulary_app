import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit_states.dart';
import 'package:vocabulary_app/model/word_model.dart';
import 'package:vocabulary_app/views/widgets/exception_widget.dart';
import 'package:vocabulary_app/views/widgets/word_item_widget.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
      builder: (context, state) {
        if (state is ReadDataCubitSuccessState) {
          if (state.words.isEmpty) {
            return _getEmptyWordsWidget();
          }
          return _getWordsWidget(state.words);
        } else if (state is ReadDataCubitFailureState) {
          return _getFaildWidget(state.message);
        } else {
          return _getLoadingWidget();
        }
      },
    );
  }

  Widget _getWordsWidget(List<WordModel> words) {
    return GridView.builder(
      itemCount: words.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 2 / 1.5,
      ),
      itemBuilder: (context, index) {
        return WordItemWidget(word: words[index]);
      },
    );
  }

  Widget _getEmptyWordsWidget() {
    return ExceptionWidget(
      iconData: Icons.list_rounded,
      message: 'Empty Word List',
    );
  }

  Widget _getFaildWidget(String message) {
    return ExceptionWidget(iconData: Icons.error, message: message);
  }

  Widget _getLoadingWidget() {
    return Center(child: CircularProgressIndicator());
  }
}
