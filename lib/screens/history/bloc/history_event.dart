part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class HistoryInitialEvent extends HistoryEvent {}

class HistorySelectExpenseEvent extends HistoryEvent {
  final int expenseIndex;

  HistorySelectExpenseEvent(this.expenseIndex);
}

class HistoryDeselectExpenseEvent extends HistoryEvent {}
