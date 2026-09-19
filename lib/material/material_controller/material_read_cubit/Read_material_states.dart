import 'package:elwaqar/material/material_model/material_model.dart';

abstract class ReadMaterialStates {}

class ReadMaterialInitialStates extends ReadMaterialStates {}

class ReadMaterialLoadingStates extends ReadMaterialStates {}

class ReadMaterialSuccessStates extends ReadMaterialStates {
  final List<MaterialModel> materials;

  ReadMaterialSuccessStates(this.materials);
}

class ReadMaterialErrorStates extends ReadMaterialStates {
  final String msg;
  ReadMaterialErrorStates(this.msg);
}
