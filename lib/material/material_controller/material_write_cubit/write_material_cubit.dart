import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwaqar/material/material_controller/material_write_cubit/write_material_states.dart';
import 'package:elwaqar/material/material_model/material_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class WriteMaterialCubit extends Cubit<WriteMaterialStates> {
  WriteMaterialCubit() : super(WriteMaterialInitialStates());
  static WriteMaterialCubit get(context) => BlocProvider.of(context);

  final CollectionReference _materialRef = FirebaseFirestore.instance
      .collection("materials");

  String name = "";
  double amount = 0;
  double alertamount = 0;

  void updateName(String text) {
    this.name = text;
    emit((WriteMaterialInitialStates()));
  }

  void updateAmount(double amount) {
    this.amount = amount;
    emit((WriteMaterialInitialStates()));
  }

  void updateAlertAmount(double AlertAmount) {
    this.alertamount = AlertAmount;
    emit((WriteMaterialInitialStates()));
  }

  void addMaterial(String name, double amount, double alertAmount) {
    _tryAndCatchBloc(() async {
      final newMaterial = MaterialModel(
        indexAtDatabase: "",
        alertAmount: alertAmount,
        name: name,
        amount: amount,
      );

      await _materialRef.add(newMaterial.toMap());

      emit(WriteMaterialSuccessStates());
    }, "error in add new material");
  }

  void deleteMaterial(String materialId) {
    _tryAndCatchBloc(() async {
      if (materialId.isEmpty) {
        throw Exception("id of material is empty");
      }
      _materialRef.doc(materialId).delete();

      emit(WriteMaterialSuccessStates());
    }, "error in add new material");
  }

  void editMaterial(
    String indexOfMaterial,
    double alertAmount,
    String name,
    double amount,
  ) {
    _tryAndCatchBloc(() async {
      MaterialModel newmaterial = MaterialModel(
        alertAmount: alertAmount,
        name: name,
        amount: amount,
        indexAtDatabase: indexOfMaterial,
      );

      _materialRef.doc("indexOfMaterial").set(newmaterial.toMap());
      emit(WriteMaterialSuccessStates());
    }, "error in add new material");
  }

  void _tryAndCatchBloc(Future<void> Function() func, String msg) async {
    emit(WriteMaterialLoadingStates());
    try {
      await func.call();
    } catch (error) {
      emit(WriteMaterialErrorStates(msg.toString()));
    }
  }
}
