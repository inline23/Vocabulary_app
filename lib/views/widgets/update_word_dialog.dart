import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:vocabulary_app/views/widgets/arabic_or_english_widget.dart';
import 'package:vocabulary_app/views/widgets/custom_form.dart';
import 'package:vocabulary_app/views/widgets/done_button.dart';

class UpdateWordDialog extends StatefulWidget {
  const UpdateWordDialog({
    super.key,
    required this.isExample,
    required this.colorCode,
    required this.indexAtDatabase,
  });

  final bool isExample;
  final int colorCode;
  final int indexAtDatabase;

  @override
  State<UpdateWordDialog> createState() => _UpdateWordDialogState();
}

class _UpdateWordDialogState extends State<UpdateWordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(30),
      backgroundColor: Color(widget.colorCode),
      child: BlocConsumer<WriteDataCubit, WriteDataCubitStates>(
        listener: (context, state) {
          if (state is WriteDataCubitSuccessState) {
            Navigator.pop(context);
          }
          if (state is WriteDataCubitFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(_getSnakBar(state));
          }
        },

        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArabicOrEnglishWidget(
                  colorCode: widget.colorCode,
                  arabicIsSelected: WriteDataCubit.get(context).isArabic,
                ),
                const SizedBox(height: 20),
                CustomForm(
                  label: widget.isExample ? 'New Example' : "New Similar word",
                  formKey: _formKey,
                ),
                const SizedBox(height: 20),

                DoneButton(
                  colorCode: widget.colorCode,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isExample) {
                        WriteDataCubit.get(
                          context,
                        ).addExample(widget.indexAtDatabase);
                      } else {
                        WriteDataCubit.get(
                          context,
                        ).addSimilarWord(widget.indexAtDatabase);
                      }
                      ReadDataCubit.get(context).getWords();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SnackBar _getSnakBar(WriteDataCubitFailureState state) =>
      SnackBar(backgroundColor: Colors.redAccent, content: Text(state.message));
}
