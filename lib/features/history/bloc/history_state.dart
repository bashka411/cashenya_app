part of 'history_bloc.dart';

@immutable
sealed class HistoryState {}

abstract class HistoryActionState extends HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryDefaultState extends HistoryState {}

class HistoryExpenseSelectedState extends HistoryState {
  final int selectedItemIndex;

  HistoryExpenseSelectedState(this.selectedItemIndex);
}
