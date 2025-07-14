import 'package:vocabulary_app/model/word_model.dart';

abstract class ReadDataCubitStates {}

class ReadDataCubitInitialState extends ReadDataCubitStates {}

class ReadDataCubitLoadingState extends ReadDataCubitStates {}

class ReadDataCubitSuccessState extends ReadDataCubitStates {
  final List<WordModel> words;
  ReadDataCubitSuccessState({required this.words});
}

class ReadDataCubitFailureState extends ReadDataCubitStates {
  final String message;
  ReadDataCubitFailureState({required this.message});
}
