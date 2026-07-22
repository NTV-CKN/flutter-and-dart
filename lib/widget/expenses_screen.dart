import 'package:flutter/material.dart';
import 'package:second_app/data/source/expense_raf.dart';
import 'package:second_app/model/expense.dart';
import 'package:second_app/widget/expense_list/expense_list_screen.dart';
import 'package:second_app/widget/add_or_update_expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Expense> expenses = [];

  void showAddExpense() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpenseScreen.add(_addNewExpense),
    );
  }

  void showUpdateExpense(Expense expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpenseScreen.update(
        _updateExpense,
        expense: expense,
      ),
    );
  }

  Future<void> _reloadExpenses() async {
    expenses = await expenseRafhelper.getExpenses();
    setState(() {});
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

  @override
  void initState() {
    _reloadExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text('Chart'),
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
