import 'package:flutter/material.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';

class ColorsListViewWidget extends StatelessWidget {
  final int activeColorCode;
  ColorsListViewWidget({super.key, required this.activeColorCode});

  final List<int> _colorsCodes = [
    0xFF193264,
    0xFF0068B2,
    0XFF4A47A3,
    0XFF0C7B93,
    0xFF892CDC,
    0XFFBC6FF1,
    0xFFF4ABC4,
    0XFFC70039,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _colorsCodes.length,
        itemBuilder: (context, index) => _getItemDesign(index, context),
        separatorBuilder: (context, index) => const SizedBox(width: 7),
      ),
    );
  }

  Widget _getItemDesign(int index, BuildContext context) {
    return InkWell(
      onTap:
          () =>
              WriteDataCubit.get(context).updateColorCode(_colorsCodes[index]),
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border:
              activeColorCode == _colorsCodes[index]
                  ? Border.all(color: ColorManager.white, width: 2)
                  : null,
          color: Color(_colorsCodes[index]),
        ),
        child: Center(
          child:
              activeColorCode == _colorsCodes[index]
                  ? Icon(Icons.done, color: ColorManager.white)
                  : null,
        ),
      ),
    );
  }
}
