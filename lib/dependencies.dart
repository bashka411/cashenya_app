import 'package:cashenya_app/app_router.dart';
import 'package:cashenya_app/data/repository/expenses/expense_firebase_data_source.dart';
import 'package:cashenya_app/data/repository/expenses/expense_hive_data_source.dart';
import 'package:cashenya_app/data/repository/expenses/expense_repository.dart';
import 'package:cashenya_app/screens/history/bloc/history_bloc.dart';
import 'package:cashenya_app/screens/home/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<HomeBloc>(HomeBloc());
  getIt.registerSingleton<HistoryBloc>(HistoryBloc());
  getIt.registerSingleton<ExpenseRepository>(ExpenseRepository());
  getIt.registerSingleton<ExpenseHiveDataSource>(ExpenseHiveDataSource());
  getIt.registerSingleton<ExpenseFirebaseDataSource>(ExpenseFirebaseDataSource());
}
