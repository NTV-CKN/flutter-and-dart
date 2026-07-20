import 'package:flutter/material.dart';
import 'package:second_app/model/expense.dart';
import 'package:second_app/widget/expense_list/expense_item.dart';

class ExpenseListScreen extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseListScreen(this.expenses, {super.key});

  Widget? itemBuilder(BuildContext cxt, int index) {
    if (index >= expenses.length) return null;

    return ExpenseItem(expenses[index]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: itemBuilder,
    );
  }
}