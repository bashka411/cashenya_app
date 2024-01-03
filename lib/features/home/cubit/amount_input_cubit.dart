import 'package:bloc/bloc.dart';
import 'package:cashenya_app/dependencies.dart';
import 'package:cashenya_app/features/home/bloc/home_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

part 'amount_input_state.dart';

class AmountInputCubit extends Cubit<AmountInputState> {
  AmountInputCubit() : super(AmountInputState.initial());

  void appendSymbol(String newAmount) {
    final String output;
    if (state.amount == '0' && state.status != AmountInputStatus.initial && newAmount == '0') return;
    if (state.amount == '0' && state.status != AmountInputStatus.initial) {
      output = formatNewValue('', newAmount);
    } else {
      output = formatNewValue(state.amount, newAmount);
    }
    emit(AmountInputState(amount: output, status: AmountInputStatus.valid));
  }

  void removeLastSymbol() {
    if (state.amount.isEmpty) {
      HapticFeedback.lightImpact();
      return;
    }
    if (state.amount.length == 1) {
      emit(AmountInputState.initial());
      return;
    }

    final int lastSymbolIndex = state.amount.length - 1;
    final String output = state.amount.substring(0, lastSymbolIndex);
    emit(AmountInputState(amount: output, status: AmountInputStatus.valid));
  }

  String formatNewValue(String oldValue, String newValue) {
    final validPattern = RegExp(r'^\d+(\.\d{0,2})?$');
    final output = oldValue + newValue;

    if (state.status == AmountInputStatus.initial) {
      return newValue;
    }

    if (!validPattern.hasMatch(output)) {
      HapticFeedback.lightImpact();
      return oldValue;
    }

    return output;
  }

  String formatNumber(String input) {
    List<String> parts = input.split(".");
    if (parts.length == 1) {
      return ".00";
    }
    if (parts[1].isEmpty) {
      return "00";
    }
    if (parts[1].length == 1) {
      return "0";
    }
    return '';
  }

  void addTransaction() {
    final stringAmount = state.amount + formatNumber(state.amount);
    final double output = double.parse(stringAmount);

    final homeBloc = getIt<HomeBloc>();
    homeBloc.add(HomeNewExpenseAddedEvent(output));
  }

  AmountInputStatus validateInputValue(String value) {
    //TODO: Implement this function
    return AmountInputStatus.valid;
  }
}
