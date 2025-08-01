import 'package:flutter/material.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';

class UpdateWordBotton extends StatelessWidget {
  const UpdateWordBotton({super.key, required this.color, required this.onTap});

  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 35,
        decoration: _getBoxDecoration(),
        child: Icon(Icons.add, color: ColorManager.white),
      ),
    );
  }

  BoxDecoration _getBoxDecoration() =>
      BoxDecoration(borderRadius: BorderRadius.circular(16), color: color);
}
