part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeNewExpenseAddedEvent extends HomeEvent {
  final double expenseAmount;

  HomeNewExpenseAddedEvent(this.expenseAmount);
}

// class HomeUndoNewExpenseAddedEvent extends HomeEvent {}

class HomeNavigateToSettingsEvent extends HomeEvent {}

class HomeNavigateToHistoryEvent extends HomeEvent {}

class HomeNavigateBackToHomeEvent extends HomeEvent {}
