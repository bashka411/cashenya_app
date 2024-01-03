import 'package:cashenya_app/data/models/expense.dart';
import 'package:cashenya_app/data/repository/expenses/expense_repository.dart';
import 'package:cashenya_app/dependencies.dart';
import 'package:cashenya_app/features/history/bloc/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          style: ButtonStyle(
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide.none,
              ),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('History'),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: const Column(
          children: [
            HistorySearchBar(),
            SizedBox(height: 12),
            HistoryExpensesListView(),
          ],
        ),
      ),
    );
  }
}

class HistorySearchBar extends StatelessWidget {
  const HistorySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBarFocusNode = FocusNode();
    final themeData = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            showDateRangePicker(
              context: context,
              firstDate: DateTime.now().subtract(
                const Duration(days: 365),
              ),
              lastDate: DateTime.now(),
              builder: (context, dateRangePicker) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: dateRangePicker,
                );
              },
            );
          },
          icon: const Icon(Icons.date_range_rounded, size: 25),
          style: themeData.iconButtonTheme.style!.copyWith(
            side: const MaterialStatePropertyAll<BorderSide>(
              BorderSide.none,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 48,
            child: TextField(
              onTapOutside: (_) => searchBarFocusNode.unfocus(),
              focusNode: searchBarFocusNode,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: themeData.colorScheme.onPrimary,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(.5),
                ),
                prefixIcon: const Icon(Icons.search_rounded, size: 25),
                contentPadding: EdgeInsets.zero,
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: themeData.colorScheme.onPrimary,
                    width: 3,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: themeData.colorScheme.onPrimary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HistoryExpensesListView extends StatefulWidget {
  const HistoryExpensesListView({super.key});

  @override
  State<HistoryExpensesListView> createState() => _HistoryExpensesListViewState();
}

class _HistoryExpensesListViewState extends State<HistoryExpensesListView> {
  int _selectedItemIndex = -1;

  void setSelectedListItem(int index) {
    setState(() {
      _selectedItemIndex = _selectedItemIndex == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenses = getIt<ExpenseRepository>().state;
    expenses.sort((b, a) => a.timestamp.compareTo(b.timestamp));

    final DateTime now = DateTime.now();
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        itemBuilder: (context, i) {
          final DateTime expenseDate = expenses[i].timestamp.toDate();
          final String dividerText;
          bool shouldPlaceDivider = true;

          if (expenseDate.year == now.year && expenseDate.month == now.month && expenseDate.day == now.day) {
            dividerText = 'Today';
          } else if (expenseDate.year == now.year && expenseDate.month == now.month && expenseDate.day == now.day - 1) {
            dividerText = 'Yesterday';
          } else {
            dividerText = DateFormat('dd.MM.yy').format(expenseDate);
          }
          if (i > 0) {
            final DateTime previousDate = expenses[i - 1].timestamp.toDate();

            bool isDifferentDays(DateTime currentDay, DateTime previousDay) {
              return currentDay.year != previousDay.year ||
                  currentDay.month != previousDay.month ||
                  currentDay.day != previousDay.day;
            }

            shouldPlaceDivider = isDifferentDays(expenseDate, previousDate);
          }
          return HistoryExpensesListItem(
            expenses[i],
            listItemIndex: i,
            selectedItemIndex: _selectedItemIndex,
            setSelectedListItem: setSelectedListItem,
            shouldPlaceDivider: shouldPlaceDivider,
            dividerText: dividerText,
          );
        },
        itemCount: expenses.length,
      ),
    );
  }
}

class HistoryExpensesListItem extends StatefulWidget {
  const HistoryExpensesListItem(
    this.expense, {
    required this.listItemIndex,
    required this.selectedItemIndex,
    required this.setSelectedListItem,
    required this.shouldPlaceDivider,
    required this.dividerText,
    super.key,
  });

  final Expense expense;
  final int listItemIndex;
  final int selectedItemIndex;
  final Function setSelectedListItem;
  final bool shouldPlaceDivider;
  final String dividerText;

  @override
  State<HistoryExpensesListItem> createState() => _HistoryExpensesListItemState();
}

class _HistoryExpensesListItemState extends State<HistoryExpensesListItem> {
  late bool isExpanded = false;
  late DateTime dateTime;

  @override
  void initState() {
    dateTime = widget.expense.timestamp.toDate();
    super.initState();
  }

  RichText amountRichText({required double amount, required Color color}) {
    final expenseRawAmount = amount.toStringAsFixed(2);
    final expenseAmountLength = expenseRawAmount.length;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: expenseRawAmount.substring(0, expenseAmountLength - 3),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 40,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
          TextSpan(
            text: expenseRawAmount.substring(expenseAmountLength - 3),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 25,
              fontWeight: FontWeight.w300,
              color: color.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> showDateTimePicker() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      // theme: Theme.of(context).copyWith(),
      context: context,
      initialDate: widget.expense.timestamp.toDate(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      is24HourMode: true,
      isShowSeconds: false,
      minutesInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      barrierDismissible: true,
    );
    return dateTime;
  }

  @override
  Widget build(BuildContext context) {
    final historyBloc = getIt<HistoryBloc>();
    final isExpanded = widget.listItemIndex == widget.selectedItemIndex;
    final themeData = Theme.of(context);
    final nameTextController = TextEditingController(text: widget.expense.name ?? 'Add description');
    final amountTextController = TextEditingController(text: widget.expense.amount.toStringAsFixed(2));

    return Column(
      children: [
        widget.shouldPlaceDivider ? HistoryDateDivider(widget.dividerText) : const SizedBox.shrink(),
        InkWell(
          enableFeedback: false,
          onTap: () {
            widget.setSelectedListItem(widget.listItemIndex);
            historyBloc.add(HistorySelectExpenseEvent(widget.listItemIndex));
          },
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: isExpanded
                ? BoxDecoration(
                    color: themeData.colorScheme.surface.withOpacity(.2),
                    border: Border.all(width: 0),
                    borderRadius: BorderRadius.circular(15),
                  )
                : null,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: isExpanded
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Amount:',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Time: ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      child: TextButton(
                                        style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                          ),
                                          padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
                                        ),
                                        onPressed: () {
                                          showDateTimePicker();
                                        },
                                        child: Text(
                                          DateFormat('HH:mm').format(widget.expense.timestamp.toDate()),
                                          style: TextStyle(
                                            color: themeData.colorScheme.onPrimary,
                                            fontSize: 36,
                                            decoration: TextDecoration.underline,
                                            decorationColor: themeData.colorScheme.onPrimary.withOpacity(.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: amountTextController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: themeData.colorScheme.onPrimary,
                                  decorationColor: themeData.colorScheme.onPrimary.withOpacity(.5),
                                  fontFamily: 'Inter',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Description:',
                                style: TextStyle(fontSize: 14),
                              ),
                              TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: nameTextController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: themeData.colorScheme.onPrimary.withOpacity(.5),
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const Dialog(
                                          child: Center(
                                            child: Text('a'),
                                          ),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          side: BorderSide.none,
                                        ),
                                      ),
                                      backgroundColor: MaterialStatePropertyAll(themeData.colorScheme.error),
                                    ),
                                    child: const Text('Delete'),
                                  ),
                                  ElevatedButton(
                                    onPressed: null,
                                    style: ButtonStyle(
                                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          side: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    child: const Text('Save'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        amountRichText(amount: widget.expense.amount, color: themeData.colorScheme.onPrimary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  '',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  widget.expense.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class HistoryDateDivider extends StatelessWidget {
  final String dividerDate;
  const HistoryDateDivider(this.dividerDate, {super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surface.withOpacity(.7);
    return Row(
      children: [
        HistoryDividerLine(color),
        Expanded(
          child: Text(
            dividerDate,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        HistoryDividerLine(color),
      ],
    );
  }
}

class HistoryDividerLine extends StatelessWidget {
  final Color color;
  const HistoryDividerLine(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: .5,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
