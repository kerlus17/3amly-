import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_write_cubit/write_expenses_states.dart';
import 'package:elwaqar/Expenses/Expenses_model/expenses_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteExpensesCubit extends Cubit<WriteExpensesStates> {
  WriteExpensesCubit() : super(WriteExpensesInitialStates());
  static WriteExpensesCubit get(context) => BlocProvider.of(context);

  CollectionReference _expensesref = FirebaseFirestore.instance.collection("Expenses");

  String name = "";
  double price = 0;
  DateTime date = DateTime.now();

  void updateName(String text) {
    this.name = text;
    emit((WriteExpensesInitialStates()));
  }

  void updatePrice(double price) {
    this.price = price;
    emit((WriteExpensesInitialStates()));
  }

  void updateDate(DateTime date) {
    this.date = date;
    emit((WriteExpensesInitialStates()));
  }

  void addExpense(String name, DateTime date, double price) {
    _tryAndCatchBloc(() async {
      final newExpense = ExpenseModel(
        indexAtDatabase: "",
        name: name,
        date: date,
        price: price,
      );
      _expensesref.add(newExpense.toMap());
      emit(WriteExpensesSuccessStates());
    }, "error in add new expense");
  }

  void editeExpense(
    String indexAtDatabase,
    DateTime date,
    String name,
    double price,
  ) {
    _tryAndCatchBloc(() async {
      final ExpenseModel newexpense = ExpenseModel(
        date: date,
        indexAtDatabase: indexAtDatabase,
        name: name,
        price: price,
      );
      _expensesref.doc(indexAtDatabase).set(newexpense.toMap());

      emit(WriteExpensesSuccessStates());
    }, "error in add new expense");
  }

  void deleteExpense(String indexAtDatabase) {
    _tryAndCatchBloc(() async {
      _expensesref.doc(indexAtDatabase).delete();

      emit(WriteExpensesSuccessStates());
    }, "error in add new expense");
  }

  void _tryAndCatchBloc(Future<void> Function() func, String msg) async {
    emit(WriteExpensesLoadingStates());
    try {
      await func.call();
    } catch (error) {
      emit(WriteExpensesErrorStates(msg.toString()));
    }
  }
}
