import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  learn('Mua dụng cụ học tập, tiền làm nhóm,...'),
  skincare('Mua thuốc bôi mụn, mặt nạ nha đam, ...'),
  hangout('Đi uống cafe, ăn xế với bạn bè, ...'),
  maintance('Tiền bảo dưỡng xe, thay lọc gió, ...');

  final String description;

  const Category(this.description);
}

class Expense {
  final String id;
  String title;
  double amount;
  DateTime date;
  Category category;

  Expense(
    {required this.title, required this.amount, required this.date, required this.category}
    ) : id = uuid.v4();
}
