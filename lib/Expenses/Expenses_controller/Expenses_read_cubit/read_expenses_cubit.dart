import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_read_cubit/Read_expenses_states.dart';
import 'package:elwaqar/Expenses/Expenses_model/expenses_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadExpensesCubit extends Cubit<ReadExpensesStates> {
  ReadExpensesCubit() : super(ReadExpensesInitialStates());
  static ReadExpensesCubit get(context) => BlocProvider.of(context);

  final CollectionReference _expensesref = FirebaseFirestore.instance.collection(
    "Expenses",
  );
  StreamSubscription? _subscription;
  List<ExpenseModel> _cashedExpenses = [];

 

   void getExpenses() {
    emit(ReadExpensesLoadingStates());

    _subscription?.cancel();
    _subscription = _expensesref.snapshots().listen(
      (snapshot) {
      _cashedExpenses=  snapshot.docs
            .map(
              (doc) => ExpenseModel.fromMap(
                doc.id,
                doc.data() as Map<String, dynamic>,
              ),
            )
            .toList();
        emit( ReadExpensesSuccessStates(_cashedExpenses) );
      },
      onError: (e) {
        emit(
          ReadExpensesErrorStates(
            "Error when getting materials: ${e.toString()}",
          ),
        );
      },
    );
  }

  double get totalExpenses {
    if (_cashedExpenses.isEmpty) return 0.0;
    return _cashedExpenses.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));
  }



  @override
  Future<void> close() {
    _subscription?.cancel(); 
    return super.close();
  }
}