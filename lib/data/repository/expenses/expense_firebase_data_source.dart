import 'package:cashenya_app/data/models/expense.dart';
import 'package:cashenya_app/data/repository/expenses/expense_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseFirebaseDataSource extends ExpenseDataSource {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addExpense(Expense expense) async {
    try {
      await _firestore.collection('expenses').add(expense.toMap());
      print('Item added to Firestore successfully.');
    } catch (e) {
      print('Error adding item to Firestore: $e');
    }
  }

  @override
  Future<List<Expense>> fetchExpenses() async {
    try {
      final snapshot = await _firestore.collection('expenses').get();
      print('Items have been successfully fetched from Firestore.');
      return snapshot.docs.map((e) => Expense.fromSnapshot(e)).toList();
    } catch (e) {
      print('Error fetching items from Firestore: $e');
      return [];
    }
  }
}
