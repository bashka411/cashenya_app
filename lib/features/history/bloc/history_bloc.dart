import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitialState()) {
    on<HistoryInitialEvent>(historyInitialEvent);
    on<HistorySelectExpenseEvent>(historySelectExpenseEvent);
    on<HistoryDeselectExpenseEvent>(historyDeselectExpenseEvent);
  }

  FutureOr<void> historyInitialEvent(HistoryInitialEvent event, Emitter<HistoryState> emit) {
    emit(HistoryDefaultState());
  }

  FutureOr<void> historySelectExpenseEvent(HistorySelectExpenseEvent event, Emitter<HistoryState> emit) {
    emit(HistoryExpenseSelectedState(event.expenseIndex));
  }

  FutureOr<void> historyDeselectExpenseEvent(HistoryDeselectExpenseEvent event, Emitter<HistoryState> emit) {
    emit(HistoryDefaultState());
  }
}
