import 'package:flutter/material.dart';
import 'package:second_app/model/expense.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseScreenState();
  }
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Category category = Category.eat;
  DateTime? _date;

  void _chooseDate() async {
    _date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2070),
      initialDate: DateTime.now(),
    );
  }

  Widget _buildDateSelected() {
    return IconButton(
      onPressed: _chooseDate,
      icon: Row(
        children: [
          Text(
            _date == null ? 'No date selected' : dateFormatter.format(_date!),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.date_range,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              label: Text(
                'Title',
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    label: Text('Amount'),
                  ),
                ),
              ),
              Spacer(),
              _buildDateSelected(),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              DropdownButton<Category>(
                value: category,
                items: [
                  for (MapEntry<Category, IconData> entry
                      in iconByCategory.entries)
                    DropdownMenuItem<Category>(
                      value: entry.key,
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(entry.value),
                          Text(
                            entry.key.name.toUpperCase(),
                          ),
                        ],
                      ),
                    ),
                ],
                onChanged: (item) {
                  if (item != null) {
                    setState(() {
                      category = item;
                    });
                  }
                },
              ),
              Spacer(),
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 230, 206, 255),
                    ),
                    onPressed: () {},
                    child: Text('Save Expense'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
