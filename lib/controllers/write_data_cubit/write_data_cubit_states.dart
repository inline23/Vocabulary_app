abstract class WriteDataCubitStates {}

class WriteDataCubitInitalState extends WriteDataCubitStates {}

class WriteDataCubitLoadingState extends WriteDataCubitStates {}

class WriteDataCubitSuccessState extends WriteDataCubitStates {}

class WriteDataCubitFailureState extends WriteDataCubitStates {
  final String message;
  WriteDataCubitFailureState({required this.message});
}
