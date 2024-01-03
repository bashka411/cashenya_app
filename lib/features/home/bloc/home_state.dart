part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}

class HomeSuccessfulState extends HomeState {}

class HomeNewTransactionAddedState extends HomeState {}

class HomeNavigateToSettingsActionState extends HomeActionState {}

class HomeNavigateToHistoryActionState extends HomeActionState {}
