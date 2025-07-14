import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:vocabulary_app/views/widgets/arabic_or_english_widget.dart';
import 'package:vocabulary_app/views/widgets/colors_list_view_widget.dart';
import 'package:vocabulary_app/views/widgets/custom_form.dart';
import 'package:vocabulary_app/views/widgets/done_button.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<WriteDataCubit , WriteDataCubitStates>(
        listener: (context, state) {
          if (state is WriteDataCubitSuccessState) {
            Navigator.pop(context);
          } else if (state is WriteDataCubitFailureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(_getSnackBar(state.message));
          }
        },
        builder: (context, state) {
          return AnimatedContainer(
            padding: EdgeInsets.all(10),
            duration: Duration(microseconds: 500),
            color: Color(WriteDataCubit.get(context).colorCode),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ArabicOrEnglishWidget(
                    colorCode: WriteDataCubit.get(context).colorCode,
                    arabicIsSelected: WriteDataCubit.get(context).isArabic,
                  ),
                  const SizedBox(height: 10),
                  ColorsListViewWidget(
                    activeColorCode: WriteDataCubit.get(context).colorCode,
                  ),
                  const SizedBox(height: 10),
                  CustomForm(label: 'New Word', formKey: formKey),
                  const SizedBox(height: 15),
                  DoneButton(
                    colorCode: WriteDataCubit.get(context).colorCode,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        WriteDataCubit.get(context).addWord();
                        ReadDataCubit.get(context).getWords();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SnackBar _getSnackBar(String message) {
    return SnackBar(content: Text(message) , backgroundColor: Colors.redAccent,);
  }
}
