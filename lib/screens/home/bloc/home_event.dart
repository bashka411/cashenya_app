part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeInputSymbolRemovedEvent extends HomeEvent {}

class HomeInputSymbolAddedEvent extends HomeEvent {
  final String symbol;
  HomeInputSymbolAddedEvent(this.symbol);
}

class HomeInputValueChangedEvent extends HomeEvent {
  final String newValue;
  HomeInputValueChangedEvent(this.newValue);
}

class HomeAddExpenseButtonClickedEvent extends HomeEvent {}

class HomeUndoAddExpenseButtonClickedEvent extends HomeEvent {}

class HomeNavigateToSettingsEvent extends HomeEvent {}

class HomeNavigateToHistoryEvent extends HomeEvent {}

class HomeNavigateBackToHomeEvent extends HomeEvent {}
