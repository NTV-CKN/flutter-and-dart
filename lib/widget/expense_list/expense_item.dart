import 'package:flutter/material.dart';
import 'package:second_app/model/expense.dart';

// ignore: must_be_immutable
class ExpenseItem extends StatelessWidget {
  Expense expense;
  final Future<void> Function(Expense expense) removeExpense;

  ExpenseItem(this.expense, {super.key, required this.removeExpense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(
                      left: 10,
                    ),
                    child: Text(
                      maxLines: 3,
                      expense.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    final scaffold = ScaffoldMessenger.of(context);
                    scaffold.clearSnackBars();
                    scaffold.showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text('Do you want delete this expense?'),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () {
                            removeExpense.call(expense);
                          },
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.remove_circle,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
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
