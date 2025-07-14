import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vocabulary_app/hive_constants.dart';
import 'package:vocabulary_app/model/word_type_adapter.dart';
import 'package:vocabulary_app/views/screens/home_screen.dart';
import 'package:vocabulary_app/views/styles/theme_manager.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  await Hive.openBox(HiveConstants.wordsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeManager.getAppTheme(),
    );
  }
}
