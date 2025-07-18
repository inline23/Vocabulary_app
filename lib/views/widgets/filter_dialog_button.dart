import 'package:flutter/material.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';
import 'package:vocabulary_app/views/widgets/filter_dialog.dart';

class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return FilterDialog();
          },
        );
      },
      child: CircleAvatar(
        radius: 18,
        backgroundColor: ColorManager.darkBlue,
        child: Icon(Icons.filter_list, color: ColorManager.white),
      ),
    );
  }
}
