abstract class WriteMaterialStates {}

class WriteMaterialInitialStates extends WriteMaterialStates {}

class WriteMaterialLoadingStates extends WriteMaterialStates {}

class WriteMaterialSuccessStates extends WriteMaterialStates {}

class WriteMaterialErrorStates extends WriteMaterialStates {
  final String msg;
  WriteMaterialErrorStates(this.msg);
}
