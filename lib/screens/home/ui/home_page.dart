import 'package:cashenya_app/dependencies.dart';
import 'package:cashenya_app/screens/home/bloc/home_bloc.dart';
import 'package:cashenya_app/screens/home/ui/widgets/amount_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getIt<HomeBloc>().add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = getIt<HomeBloc>();
    final themeData = Theme.of(context);
    String? totalAmount;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        buildWhen: (previous, current) => current is! HomeActionState,
        listenWhen: (previous, current) => current is HomeActionState,
        listener: (context, state) {
          if (state.runtimeType == HomeNavigateToHistoryActionState) {
            Navigator.of(context).pushNamed('/history-page').then((_) => {});
          }
        },
        builder: (context, homeState) {
          if (homeState is HomeTotalAmountLoadedState) {
            totalAmount = homeState.amount.toStringAsFixed(2);
          }
          return Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: RichText(
                        text: TextSpan(
                          style: themeData.textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: '₴ ',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w500,
                                color: themeData.colorScheme.surface,
                              ),
                            ),
                            TextSpan(
                              text: totalAmount ?? 'Loading...',
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings_rounded,
                      ),
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide.none,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(12.5),
                    ),
                  ],
                ),
                const PeriodWidget(),
                const Spacer(),
                AmountInputWidget(homeBloc, homeState),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PeriodWidget extends StatelessWidget {
  const PeriodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = getIt<HomeBloc>();
    final theme = Theme.of(context);
    return Row(
      children: [
        const Icon(Icons.restore_rounded),
        const Text(' '),
        const Text(
          'Period',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(' '),
        InkWell(
          onTap: () {
            homeBloc.add(HomeNavigateToHistoryEvent());
          },
          borderRadius: BorderRadius.circular(5),
          child: Text(
            'from 01.08 to 31.08',
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: theme.colorScheme.primary,
              color: theme.colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
