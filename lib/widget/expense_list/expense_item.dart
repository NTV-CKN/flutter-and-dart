import 'package:flutter/material.dart';
import 'package:second_app/model/expense.dart';

// ignore: must_be_immutable
class ExpenseItem extends StatelessWidget {
  Expense expense;

  ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: Card(
        child: Column(
          children: [
            Text(expense.title),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Row(
                children: [
                  Text('${expense.amount.toStringAsFixed(3)} VNĐ'),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        expense.iconDataByCategory,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        expense.dateFormat,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
