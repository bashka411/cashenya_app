import 'package:cashenya_app/app_router.dart';
import 'package:cashenya_app/data/repository/boxes.dart';
import 'package:cashenya_app/data/models/expense.dart';
import 'package:cashenya_app/data/repository/timestamp_adapter.dart';
import 'package:cashenya_app/dependencies.dart' as get_it;
import 'package:cashenya_app/dependencies.dart';
import 'package:cashenya_app/firebase_options.dart';
import 'package:cashenya_app/screens/home/bloc/home_bloc.dart';
import 'package:cashenya_app/themes.dart';

import 'package:firebase_core/firebase_core.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
        ],
        child: MaterialApp(
          initialRoute: '/home-page',
          onGenerateRoute: getIt<AppRouter>().onGenerateRoute,
          title: 'Cashenya',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: ThemeClass.lightTheme,
          darkTheme: ThemeClass.darkTheme,
        ),
      );
    });
  }
}
