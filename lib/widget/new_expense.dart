import 'package:flutter/material.dart';
import 'package:second_app/model/expense.dart';

class NewExpenseScreen extends StatefulWidget {
  final Future<void> Function(Expense expense) addNewExpense;

  const NewExpenseScreen(this.addNewExpense, {super.key});

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
    setState(() {});
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

  Future<void> addNewExpense() async {
    final String title = _titleController.text;
    final double? amount = double.tryParse(_amountController.text);

    if (title.isEmpty || amount == null || _date == null) {
      showDialog(
        context: context,
        builder: ((context) => AlertDialog(
          title: Text(
            'Invalid Input!',
          ),
          content: Text('Title, amount, and date are required.'),
        )),
      );

      return;
    }

    Navigator.pop(context);

    await widget.addNewExpense.call(
      Expense(
        title: title,
        amount: amount,
        date: _date!,
        category: category,
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
            maxLength: 50,
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
                    suffixText: 'VNĐ',
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
              Expanded(
                child: DropdownButton<Category>(
                  value: category,
                  items: [
                    for (MapEntry<Category, IconData> entry
                        in iconByCategory.entries)
                      DropdownMenuItem<Category>(
                        value: entry.key,
                        child: Tooltip(
                          message: entry.key.description,
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
              ),
              Expanded(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: addNewExpense,
                      child: Text('Save'),
                    ),
                  ],
                ),
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
