import 'package:flutter/material.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  const ArabicOrEnglishWidget({
    super.key,
    required this.colorCode,
    required this.arabicIsSelected,
  });
  final int colorCode;
  final bool arabicIsSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getContainerDesign(true , context),
        SizedBox(width: 5),
        _getContainerDesign(false , context),
      ],
    );
  }

  InkWell _getContainerDesign(bool buildIsArabic , BuildContext context) {
    return InkWell(
      onTap: () => WriteDataCubit.get(context).isArabic,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: ColorManager.white),
          color:
              buildIsArabic == arabicIsSelected
                  ? ColorManager.white
                  : Color(colorCode),
        ),
        width: 50,
        height: 50,
        child: Center(
          child: Text(
            buildIsArabic ? "ar" : "en",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  !(buildIsArabic == arabicIsSelected)
                      ? ColorManager.white
                      : Color(colorCode),
            ),
          ),
        ),
      ),
    );
  }
}
