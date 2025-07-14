import 'package:flutter/material.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';
import 'package:vocabulary_app/views/widgets/add_word_dialog.dart';
import 'package:vocabulary_app/views/widgets/colors_list_view_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFloatingActionButton(),
      appBar: AppBar(title: Text('Home')),
      body: Column(
        children: [ColorsListViewWidget(activeColorCode: 0xFF193264)],
      ),
    );
  }
}

class _getFloatingActionButton extends StatelessWidget {
  const _getFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManager.white,
      onPressed:
          () => showDialog(
            context: context,
            builder: (context) => AddWordDialog(),
          ),
          child: Icon(Icons.add, color: ColorManager.darkBlue,),
    );
  }
}
