import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cashenya_app/data/repository/expenses/expense_repository.dart';
import 'package:cashenya_app/dependencies.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeNavigateToSettingsEvent>(homeNavigateSettingsButtonClicked);
    on<HomeNavigateToHistoryEvent>(homeNavigateHistoryButtonClicked);
    // on<HomeInputSymbolAddedEvent>(homeInputSymbolAddedEvent);
    // on<HomeInputValueChangedEvent>(homeInputValueChangedEvent);
    // on<HomeInputSymbolRemovedEvent>(homeInputSymbolRemovedEvent);
    // on<HomeAddExpenseButtonClickedEvent>(homeAddExpenseButtonClickedEvent);
    on<HomeUndoAddExpenseButtonClickedEvent>(homeUndoAddExpenseButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final expensesRepository = getIt<ExpenseRepository>();
    await expensesRepository.loadExpenses();
    final totalAmount = expensesRepository.totalAmount;
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeTotalAmountLoadedState(totalAmount));
  }

  FutureOr<void> homeNavigateSettingsButtonClicked(HomeNavigateToSettingsEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToSettingsActionState());
  }

  FutureOr<void> homeNavigateHistoryButtonClicked(HomeNavigateToHistoryEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToHistoryActionState());
  }

  // FutureOr<void> homeInputSymbolAddedEvent(HomeInputSymbolAddedEvent event, Emitter<HomeState> emit) {
  //   final oldValue = state is HomeInitialState ? '' : state.amount;
  //   if (oldValue == '0' && event.symbol == '0') {
  //     print('Vibration Feedback');
  //     return null;
  //   }

  //   final newValue = oldValue + event.symbol;
  //   final returnValue = format(oldValue, newValue);
  //   add(HomeInputValueChangedEvent(returnValue));
  // }

  // FutureOr<void> homeInputSymbolRemovedEvent(HomeInputSymbolRemovedEvent event, Emitter<HomeState> emit) {
  //   final value = state.amount;
  //   final returnValue = value.substring(0, value.length - 1);
  //   if (returnValue.isEmpty || returnValue == '0') {
  //     emit(HomeInitialState());
  //     return null;
  //   }
  //   add(HomeInputValueChangedEvent(returnValue));
  // }

  // FutureOr<void> homeInputValueChangedEvent(HomeInputValueChangedEvent event, Emitter<HomeState> emit) {
  //   emit(HomeInputValueEnteredState(event.newValue));
  // }

  // FutureOr<void> homeAddExpenseButtonClickedEvent(HomeAddExpenseButtonClickedEvent event, Emitter<HomeState> emit) {
  //   emit(HomeTransactionAddedState(amount));
  //   print('Add Expense Button Clicked. Value: ${state.amount}, Name: ${state.name}');
  // }

  FutureOr<void> homeUndoAddExpenseButtonClickedEvent(HomeUndoAddExpenseButtonClickedEvent event, Emitter<HomeState> emit) {}

  void validateInputValue() {}

  String format(String oldValue, String newValue) {
    final validPattern = RegExp(r'^\d+(\.\d{0,2})?$');
    if (newValue.isEmpty) {
      return newValue;
    }
    if (!validPattern.hasMatch(newValue)) {
      print('Vibration Feedback');
      return oldValue;
    }
    return newValue;
  }
}
