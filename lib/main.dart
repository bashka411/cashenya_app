import 'package:cashenya_app/app_bloc/app_bloc.dart';
import 'package:cashenya_app/app_router.dart';
import 'package:cashenya_app/auth_repository.dart';
import 'package:cashenya_app/data/repository/boxes.dart';
import 'package:cashenya_app/data/models/expense.dart';
import 'package:cashenya_app/data/repository/timestamp_adapter.dart';
import 'package:cashenya_app/dependencies.dart' as get_it;
import 'package:cashenya_app/dependencies.dart';
import 'package:cashenya_app/features/home/bloc/home_bloc.dart';
import 'package:cashenya_app/features/home/cubit/amount_display_cubit.dart';
import 'package:cashenya_app/features/home/cubit/amount_input_cubit.dart';
import 'package:cashenya_app/firebase_options.dart';
import 'package:cashenya_app/themes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TimestampAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  expensesBox = await Hive.openBox<Expense>('expensesBox');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  get_it.setup();
  final authRepository = AuthRepository();
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({required AuthRepository authRepository, super.key}) : _authRepository = authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(authRepository: _authRepository),
          ),
          BlocProvider(
            create: (context) => getIt<HomeBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<AmountInputCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<AmountDisplayCubit>(),
          )
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
              home: FlowBuilder<AuthStatus>(
                state: context.select((AppBloc bloc) => bloc.state.status),
                onGeneratePages: onGenerateAppViewPages,
              ),
              title: 'Cashenya',
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.dark,
              theme: ThemeClass.lightTheme,
              darkTheme: ThemeClass.darkTheme,
            );
          }
        ),
      ),
    );
  }
}
