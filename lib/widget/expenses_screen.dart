import 'package:flutter/material.dart';
import 'package:second_app/data/dummy_expense.dart';
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
  void addExpense() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpenseScreen(),
    );
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
