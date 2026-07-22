import 'package:second_app/model/expense.dart';

class BucketExpense {
  final Category category;
  final List<Expense> expenses;

  BucketExpense(List<Expense> allExpenses, this.category)
    : expenses = allExpenses
          .where((item) => item.category == category)
          .toList();

  double get total {
    double sum = 0;
    for (var item in expenses) {
      sum += item.amount;
    }

    return sum;
  }
}
