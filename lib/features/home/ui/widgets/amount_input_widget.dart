import 'package:cashenya_app/features/home/cubit/amount_input_cubit.dart';
import 'package:cashenya_app/features/home/ui/widgets/numpad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountInputWidget extends StatelessWidget {
  const AmountInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final amountInputCubit = context.read<AmountInputCubit>();

    return BlocBuilder<AmountInputCubit, AmountInputState>(
      bloc: amountInputCubit,
      builder: (context, state) {
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

        final String amountSuffix = formatNumber(state.amount);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            state.status == AmountInputStatus.valid ? const PressToAddExpenseHintWidget() : const SizedBox.shrink(),
            FittedBox(
                fit: BoxFit.contain,
                child: RichText(
                  text: TextSpan(
                    text: state.amount,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      color: state.status == AmountInputStatus.initial ? themeData.colorScheme.onPrimary.withOpacity(.25) : null,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: amountSuffix,
                        style: TextStyle(
                          color: themeData.colorScheme.onPrimary.withOpacity(.25),
                        ),
                      ),
                    ],
                  ),
                )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     // state is HomeNewTransactionAddedState ? const UndoTransactionWidget() : const SizedBox.shrink(),
            //     state.status == AmountInputStatus.valid ? const AddTransactionNameWidget() : const SizedBox.shrink(),
            //   ],
            // ),
            const SizedBox(height: 10),
            const NumpadWidget(),
          ],
        );
      },
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
          hintText: 'Add name',
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
