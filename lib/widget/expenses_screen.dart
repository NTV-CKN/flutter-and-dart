import 'package:flutter/material.dart';
import 'package:second_app/data/source/expense_raf.dart';
import 'package:second_app/model/expense.dart';
import 'package:second_app/widget/expense_list/expense_list_screen.dart';
import 'package:second_app/widget/new_expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Expense> expenses = [];

  void addExpense() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpenseScreen(),
    );
  }

  Future<void> reloadExpenses() async {
    expenses = await expenseRafhelper.getExpenses();
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Expense Tracker',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: addExpense,
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            const Text('Chart'),
            Expanded(
              child: ExpenseListScreen(expenses),
            ),
          ],
        ),
      ),
    );
  }
}
