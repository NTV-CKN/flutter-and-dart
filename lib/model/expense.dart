import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_app/data/source/expense_raf.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

const Map<Category, IconData> iconByCategory = {
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
  set sTitle(String title) => this.title = title;

  double amount;
  set sAmount(double amount) => this.amount = amount;

  DateTime date;
  String get dateFormat => dateFormatter.format(date);
  set sDate(DateTime date) => this.date = date;

  Category category;
  set sCategory(Category category) => this.category = category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  Expense.withId({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  IconData? get iconDataByCategory => iconByCategory[category];

  Future<void> saveExpense(RandomAccessFile raf) async {
    await raf.writeByte(1);
    await raf.writeUtf8(id);
    await raf.writeUtf8(title);

    final byteDataAmount = ByteData(8)..setFloat64(0, amount);
    await raf.writeFrom(byteDataAmount.buffer.asUint8List());
    await raf.writeByte(category.index);

    final byteDateTime = ByteData(8)..setInt64(0, date.millisecondsSinceEpoch);
    await raf.writeFrom(byteDateTime.buffer.asUint8List());
  }
}
