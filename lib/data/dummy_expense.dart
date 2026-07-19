import 'package:second_app/model/expense.dart';

final List<Expense> expenses = [
  Expense(
    amount: 100.000,
    title: 'Ăn mì cay',
    date: DateTime.now(),
    category: Category.hangout,
  ),
  Expense(
    title: 'Mua bút',
    amount: 20.000,
    date: DateTime.now(),
    category: Category.learn,
  ),
];
