import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwaqar/material/material_controller/material_read_cubit/Read_material_states.dart';
import 'package:elwaqar/material/material_model/material_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ReadMaterialCubit extends Cubit<ReadMaterialStates> {
  ReadMaterialCubit() : super(ReadMaterialInitialStates());
  static ReadMaterialCubit get(context) => BlocProvider.of(context);

  StreamSubscription? _subscription;

  final CollectionReference _materialRef = FirebaseFirestore.instance
      .collection("materials");

  List<MaterialModel> _cachedMaterials = [];

  void getMaterials() {
    emit(ReadMaterialLoadingStates());

    _subscription?.cancel();
    _subscription = _materialRef.snapshots().listen(
      (snapshot) {
        _cachedMaterials = snapshot.docs
            .map(
              (doc) => MaterialModel.fromMap(
                doc.id,
                doc.data() as Map<String, dynamic>,
              ),
            )
            .toList();
        emit(ReadMaterialSuccessStates(_cachedMaterials));
      },
      onError: (e) {
        emit(
          ReadMaterialErrorStates(
            "Error when getting materials: ${e.toString()}",
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  double getHighMaterials() {
    try {
      double total = 0;
      for (MaterialModel material in _cachedMaterials) {
        if (material.amount >= material.alertAmount) total += 1;
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }

  double getLowMaterials() {
    try {
      double total = 0;
      for (MaterialModel material in _cachedMaterials) {
        if (material.amount < material.alertAmount) total += 1;
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }
}
