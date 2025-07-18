import 'package:flutter/material.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({
    super.key,
    required this.iconData,
    required this.message,
  });
  final IconData iconData;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, color: ColorManager.darkBlue, size: 60),
        const SizedBox(height: 20),
        Text(
          message,
          style: TextStyle(color: ColorManager.darkBlue, fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
