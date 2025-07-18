import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit_states.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';

class LanguageFilterWidget extends StatelessWidget {
  const LanguageFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
      builder: (context, state) {
        return Text(
          _mapLanguageFilterEnumToString(
            ReadDataCubit.get(context).languageFilter,
          ),
          style: TextStyle(
            color: ColorManager.darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        );
      },
    );
  }

  String _mapLanguageFilterEnumToString(LanguageFilter languageFilter) {
    if (languageFilter == LanguageFilter.allWords) {
      return "All words";
    } else if (languageFilter == LanguageFilter.arabicOnly) {
      return "Arabic";
    } else {
      return 'English';
    }
  }
}
