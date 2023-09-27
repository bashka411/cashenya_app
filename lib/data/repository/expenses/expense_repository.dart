import 'package:cashenya_app/data/models/expense.dart';
import 'package:cashenya_app/data/repository/expenses/expense_firebase_data_source.dart';
import 'package:cashenya_app/data/repository/expenses/expense_hive_data_source.dart';
import 'package:cashenya_app/dependencies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseRepository extends Cubit<List<Expense>> {
  ExpenseRepository() : super([]);

  ExpenseFirebaseDataSource get _firestoreDataSource => getIt<ExpenseFirebaseDataSource>();
  ExpenseHiveDataSource get _hiveDataSource => getIt<ExpenseHiveDataSource>();

  double get totalAmount {
    double total = 0;
    for (var expense in state) {
      total += expense.amount;
    }
    return total;
  }

  List<Expense> get expenses {
    final sortedExpenses = state;
    sortedExpenses.sort((b, a) => a.timestamp.compareTo(b.timestamp));
    return sortedExpenses;
  }

  void addExpense(Expense expense) {
    final currentExpensesList = state;
    currentExpensesList.add(expense);
    _addExpenseToHive(expense);
    emit(currentExpensesList);
  }

  Future<void> loadExpenses() async {
    final expenses = await _fetchExpensesFromHive();
    emit(expenses);
  }

  Future<void> _addExpenseToFirestore(Expense expense) async {
    return await _firestoreDataSource.addExpense(expense);
  }

  Future<void> _addExpenseToHive(Expense expense) async {
    return await _hiveDataSource.addExpense(expense);
  }

  Future<List<Expense>> _fetchExpensesFromFirestore() async {
    return await _firestoreDataSource.fetchExpenses();
  }

  Future<List<Expense>> _fetchExpensesFromHive() async {
    return await _hiveDataSource.fetchExpenses();
  }
}
