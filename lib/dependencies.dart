import 'package:cashenya_app/auth_repository.dart';
import 'package:cashenya_app/data/repository/expenses/expense_firebase_data_source.dart';
import 'package:cashenya_app/data/repository/expenses/expense_hive_data_source.dart';
import 'package:cashenya_app/data/repository/expenses/expense_repository.dart';
import 'package:cashenya_app/features/history/bloc/history_bloc.dart';
import 'package:cashenya_app/features/home/bloc/home_bloc.dart';
import 'package:cashenya_app/features/home/cubit/amount_display_cubit.dart';
import 'package:cashenya_app/features/home/cubit/amount_input_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ExpenseRepository>(ExpenseRepository());
  getIt.registerSingleton<ExpenseHiveDataSource>(ExpenseHiveDataSource());
  getIt.registerSingleton<ExpenseFirebaseDataSource>(ExpenseFirebaseDataSource());
  getIt.registerSingleton<AmountInputCubit>(AmountInputCubit());
  getIt.registerSingleton<AmountDisplayCubit>(AmountDisplayCubit());
  getIt.registerSingleton<HistoryBloc>(HistoryBloc());
  getIt.registerSingleton<HomeBloc>(HomeBloc());
  getIt.registerSingleton<AuthRepository>(AuthRepository());
  
}
