import 'package:cashenya_app/data/models/expense.dart';

abstract class ExpenseDataSource {
  Future<void> addExpense(Expense expense);
  Future<List<Expense>> fetchExpenses();
}
