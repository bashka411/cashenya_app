import 'package:bloc/bloc.dart';
import 'package:cashenya_app/data/repository/expenses/expense_repository.dart';
import 'package:cashenya_app/dependencies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'amount_display_state.dart';

class AmountDisplayCubit extends Cubit<AmountDisplayState> {
  AmountDisplayCubit() : super(AmountDisplayState.initial());

  void subscribeToAmountChanges() {
    final expensesRepository = getIt<ExpenseRepository>();
    expensesRepository.stream.listen((state) {
      print('expensesRepository state changed');
      double total = 0;
      for (var expense in state) {
        total += expense.amount;
      }
      emit(AmountDisplayState(amount: total));
    });
  }
}
