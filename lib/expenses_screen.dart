import 'package:flutter/material.dart';
import 'package:second_app/data/dummy_expense.dart';
import 'package:second_app/expense_list_screen.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
