import 'package:cashenya_app/screens/home/bloc/home_bloc.dart';
import 'package:cashenya_app/screens/home/ui/widgets/numpad_widget.dart';
import 'package:flutter/material.dart';

class AmountInputWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final HomeState homeState;
  const AmountInputWidget(this.homeBloc, this.homeState, {super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final inputValue = homeState is HomeInputValueEnteredState ? (homeState as HomeInputValueEnteredState).value : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        homeState is HomeInputValueEnteredState ? const PressToAddExpenseHintWidget() : const SizedBox.shrink(),
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            homeState is HomeInputValueEnteredState ? inputValue : '0',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w600,
              color: homeState is HomeInputValueEnteredState ? null : themeData.colorScheme.onPrimary.withOpacity(.25),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            homeState is HomeTransactionAddedState ? const UndoTransactionWidget() : const SizedBox.shrink(),
            homeState is HomeInputValueEnteredState ? const AddTransactionNameWidget() : const SizedBox.shrink(),
          ],
        ),
        const SizedBox(height: 20),
        NumpadWidget(homeBloc, homeState),
      ],
    );
  }
}

class PressToAddExpenseHintWidget extends StatelessWidget {
  const PressToAddExpenseHintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Text(
                'Press ',
                style: TextStyle(
                  color: themeData.colorScheme.onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.keyboard_return_rounded,
                color: themeData.colorScheme.onBackground,
              ),
              Text(
                ' to add expense',
                style: TextStyle(
                  color: themeData.colorScheme.onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UndoTransactionWidget extends StatelessWidget {
  const UndoTransactionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(
              Icons.undo_rounded,
              size: 20,
              color: themeData.colorScheme.onBackground,
            ),
            Text(
              ' Undo',
              style: TextStyle(
                color: themeData.colorScheme.onBackground,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTransactionNameWidget extends StatefulWidget {
  const AddTransactionNameWidget({super.key});
  @override
  State<AddTransactionNameWidget> createState() => _AddTransactionNameWidgetState();
}

class _AddTransactionNameWidgetState extends State<AddTransactionNameWidget> {
  @override
  Widget build(BuildContext context) {
    final transactionNameFocusNode = FocusNode();
    final themeData = Theme.of(context);
    // final a = Padding(
    //     padding: const EdgeInsets.all(5),
    //     child: Row(children: [
    //       Icon(Icons.edit_rounded, size: 20, color: themeData.colorScheme.onBackground),
    //       Text(' Add a transaction name',
    //           style: TextStyle(color: themeData.colorScheme.onBackground, fontSize: 16, fontWeight: FontWeight.w500))
    //     ]));
    return SizedBox(
      width: 240,
      child: TextField(
        focusNode: transactionNameFocusNode,
        onTapOutside: (_) => transactionNameFocusNode.unfocus(),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.end,
        cursorColor: themeData.colorScheme.onPrimary,
        decoration: const InputDecoration(
          isDense: true,
          hintText: 'Add a transaction name',
          suffixIcon: Icon(
            Icons.edit_rounded,
            size: 20,
          ),
          contentPadding: EdgeInsets.zero,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
