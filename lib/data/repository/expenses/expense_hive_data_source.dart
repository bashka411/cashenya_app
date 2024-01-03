import 'package:cashenya_app/data/models/expense.dart';
import 'package:cashenya_app/data/repository/boxes.dart';
import 'package:cashenya_app/data/repository/expenses/expense_data_source.dart';

class ExpenseHiveDataSource extends ExpenseDataSource {

  @override
  Future<void> addExpense(Expense expense) async {
    try {
      await expensesBox.add(expense);
      // print('Item added to Hive successfully.');
    } catch (e) {
      print('Error adding item to Hive: $e');
    }
  }

  @override
  Future<List<Expense>> fetchExpenses() async {
    try {
      final expenses = expensesBox.values.cast<Expense>().toList();
      // print('Items have been successfully fetched from Hive.');
      return expenses;
    } catch (e) {
      print('Error fetching items from Hive: $e');
      return [];
    }
  }
}
