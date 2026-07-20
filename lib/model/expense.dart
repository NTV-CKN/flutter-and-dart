import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

const iconByCategory = {
  Category.learn: Icons.work,
  Category.skincare: Icons.healing_outlined,
  Category.eat: Icons.food_bank_outlined,
  Category.maintance: Icons.car_repair,
};

final dateFormatter = DateFormat.yMd();

enum Category {
  learn('Mua dụng cụ học tập, tiền làm nhóm,...'),
  skincare('Mua thuốc bôi mụn, mặt nạ nha đam, ...'),
  eat('Đi uống cafe, ăn xế với bạn bè, ...'),
  maintance('Tiền bảo dưỡng xe, thay lọc gió, ...');

  final String description;

  const Category(this.description);
}

class Expense {
  final String id;
  String title;
  double amount;
  DateTime date;
  String get dateFormat => dateFormatter.format(date);

  Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  IconData? get iconDataByCategory => iconByCategory[category];
}
