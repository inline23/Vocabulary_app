import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vocabulary_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/controllers/write_data_cubit/write_data_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReadDataCubit(),),
        BlocProvider(create: (context) => WriteDataCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: ThemeManager.getAppTheme(),
      ),
    );
  }
}
