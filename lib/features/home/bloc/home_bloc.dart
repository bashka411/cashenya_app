import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cashenya_app/data/models/expense.dart';
import 'package:cashenya_app/data/repository/expenses/expense_repository.dart';
import 'package:cashenya_app/dependencies.dart';
import 'package:cashenya_app/features/home/cubit/amount_display_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late final ExpenseRepository expensesRepository;

  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeNavigateToSettingsEvent>(homeNavigateSettingsButtonClicked);
    on<HomeNavigateToHistoryEvent>(homeNavigateHistoryButtonClicked);
    on<HomeNewExpenseAddedEvent>(homeNewExpenseAddedEvent);
    // on<HomeUndoNewExpenseAddedEvent>(homeUndoNewExpenseAddedEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    expensesRepository = getIt<ExpenseRepository>();
    expensesRepository.loadExpenses();
    getIt<AmountDisplayCubit>().subscribeToAmountChanges();
    emit(HomeSuccessfulState());
  }

  FutureOr<void> homeNavigateSettingsButtonClicked(HomeNavigateToSettingsEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToSettingsActionState());
  }

  FutureOr<void> homeNavigateHistoryButtonClicked(HomeNavigateToHistoryEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToHistoryActionState());
  }

  FutureOr<void> homeNewExpenseAddedEvent(HomeNewExpenseAddedEvent event, Emitter<HomeState> emit) {
    expensesRepository.addExpense(
      Expense(
        amount: event.expenseAmount,
        timestamp: Timestamp.now(),
      ),
    );
    emit(HomeNewTransactionAddedState());
  }

  // FutureOr<void> homeUndoNewExpenseAddedEvent(HomeUndoNewExpenseAddedEvent event, Emitter<HomeState> emit) {}
}
