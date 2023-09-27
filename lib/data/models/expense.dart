import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final Timestamp timestamp;

  Expense({
    this.id,
    this.name,
    required this.amount,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'timestamp': timestamp,
      'name': name,
    };
  }

  factory Expense.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return Expense(
      id: snapshot.id,
      name: map['name'],
      amount: map['amount'],
      timestamp: map['timestamp'],
    );
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> fromJson(String string) {
    return json.decode(string) as Map<String, dynamic>;
  }

  String toJson() {
    return json.encode(toMap());
  }
}
