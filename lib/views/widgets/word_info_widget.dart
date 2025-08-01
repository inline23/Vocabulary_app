import 'package:flutter/material.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';

class WordInfoWidget extends StatelessWidget {
  const WordInfoWidget({
    super.key,
    required this.color,
    required this.isArabic,
    required this.text,
    this.onPressed,
  });

  final Color color;
  final String text;
  final bool isArabic;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: _getBoxDecoration(),
      child: Row(
        children: [
          _getIsArabicWidget(),
          const SizedBox(width: 10),
          Expanded(child: _getTextWidget()),
          if(onPressed !=null)
          IconButton(onPressed: onPressed, icon: Icon(Icons.delete, color: ColorManager.white,)),
        ],
      ),
    );
  }

  Text _getTextWidget() {
    return Text(
      text,
      style: TextStyle(
        color: ColorManager.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  CircleAvatar _getIsArabicWidget() {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorManager.white,
      child: Text(isArabic ? 'ar' : 'en', style: TextStyle(color: color)),
    );
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(color: color, borderRadius: BorderRadius.circular(20));
  }
}
