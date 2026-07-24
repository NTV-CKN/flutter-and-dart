import 'package:flutter/material.dart';
import 'package:second_app/data/source/expense_raf.dart';
import 'package:second_app/model/bucket_expense.dart';
import 'package:second_app/model/expense.dart';
import 'package:second_app/widget/add_or_update_expense/add_or_update_expense_wgt600.dart'
    as aoue_wgt600;
import 'package:second_app/widget/add_or_update_expense/add_or_update_expense_wlt600.dart'
    as aoue_wlt600;
import 'package:second_app/widget/chart/expense_pie_chart.dart';
import 'package:second_app/widget/expense_list/expense_list_screen.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Expense> expenses = [];
  List<BucketExpense> bucketExpenses = [];

  void showAddExpense() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: double.infinity,
      ),
      builder: (ctx) => LayoutBuilder(
        builder: (ctx, boxConstrains) {
          if (boxConstrains.maxWidth >= 600) {
            return aoue_wgt600.NewExpenseScreen.addWgt600(
              _addNewExpense,
            );
          } else {
            return aoue_wlt600.NewExpenseScreen.addWlt600(
              _addNewExpense,
            );
          }
        },
      ),
    );
  }

  void showUpdateExpense(Expense expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: double.infinity,
      ),
      builder: (ctx) => LayoutBuilder(
        builder: (ctx, boxConstrains) {
          if (boxConstrains.maxWidth >= 600) {
            return aoue_wgt600.NewExpenseScreen.updateWgt600(
              _updateExpense,
              expense: expense,
            );
          } else {
            return aoue_wlt600.NewExpenseScreen.updateWlt600(
              _updateExpense,
              expense: expense,
            );
          }
        },
      ),
    );
  }

  Future<void> _reloadExpenses() async {
    expenses = await expenseRafhelper.getExpenses();
    bucketExpenses.clear();

    setState(() {
      for (var item in Category.values) {
        bucketExpenses.add(BucketExpense(expenses, item));
      }
    });
  }

  Future<void> _addNewExpense(Expense expense) async {
    await expenseRafhelper.saveExpense(expense);
    await _reloadExpenses();
  }

  Future<void> _updateExpense(Expense expense) async {
    await expenseRafhelper.updateExpense(expense);
    await _reloadExpenses();
  }

  Future<void> _removeExpense(Expense expense) async {
    await expenseRafhelper.removeExpense(expense);
    await _reloadExpenses();
  }

  Future<void> _onClear() async {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('Do you want clear all data?'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () async {
            await expenseRafhelper.clear();
            if (!mounted) return;

            await _reloadExpenses();
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    _reloadExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthSpace = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Expense Tracker',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: showAddExpense,
            icon: Icon(
              Icons.add,
            ),
          ),
          IconButton(
            onPressed: _onClear,
            icon: Icon(
              Icons.cleaning_services_sharp,
            ),
          ),
        ],
      ),
      body: Container(
        child: widthSpace > 600
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: bucketExpenses.isEmpty
                        ? Text(
                            'Chart',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          )
                        : ExpensePieChart(buckets: bucketExpenses),
                  ),
                  Expanded(
                    child: expenses.isEmpty
                        ? Icon(
                            Icons.folder_off_rounded,
                            size: 100,
                          )
                        : ExpenseListScreen(
                            expenses,
                            removeExpense: _removeExpense,
                            showUpdateModal: showUpdateExpense,
                          ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: bucketExpenses.isEmpty
                        ? Text(
                            'Chart',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          )
                        : ExpensePieChart(buckets: bucketExpenses),
                  ),
                  Expanded(
                    child: expenses.isEmpty
                        ? Icon(
                            Icons.folder_off_rounded,
                            size: 100,
                          )
                        : ExpenseListScreen(
                            expenses,
                            removeExpense: _removeExpense,
                            showUpdateModal: showUpdateExpense,
                          ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
