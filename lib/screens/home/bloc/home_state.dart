part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {
  HomeInitialState();
}

class HomeLoadingState extends HomeState {
  HomeLoadingState();
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}

class HomeTotalAmountLoadedState extends HomeState {
  final double amount;
  HomeTotalAmountLoadedState(this.amount);
}

class HomeInputValueEnteredState extends HomeState {
  final String value;
  HomeInputValueEnteredState(this.value);
}

class HomeTransactionAddedState extends HomeState {
  final double amount;

  HomeTransactionAddedState(this.amount);
}

class HomeNavigateToSettingsActionState extends HomeActionState {}

class HomeNavigateToHistoryActionState extends HomeActionState {}
