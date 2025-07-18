import 'package:flutter/material.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';
import 'package:vocabulary_app/views/widgets/add_word_dialog.dart';
import 'package:vocabulary_app/views/widgets/filter_dialog_button.dart';
import 'package:vocabulary_app/views/widgets/language_filter_widget.dart';
import 'package:vocabulary_app/views/widgets/words_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFloatingActionButton(),
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                LanguageFilterWidget(),
                Spacer(),
                FilterDialogButton(),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(child: WordsWidget()),
          ],
        ),
      ),
    );
  }
}

class _getFloatingActionButton extends StatelessWidget {
  const _getFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManager.white,
      onPressed:
          () => showDialog(
            context: context,
            builder: (context) => AddWordDialog(),
          ),
      child: Icon(Icons.add, color: ColorManager.darkBlue),
    );
  }
}
