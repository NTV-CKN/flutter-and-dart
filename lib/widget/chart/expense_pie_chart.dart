import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:second_app/model/bucket_expense.dart';
import 'package:second_app/model/expense.dart';

class ExpensePieChart extends StatefulWidget {
  final List<BucketExpense> buckets;

  const ExpensePieChart({super.key, required this.buckets});

  @override
  State<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double totalAllExpenses = widget.buckets.fold(
      0,
      (sum, bucket) => sum + bucket.total,
    );

    return SizedBox(
      height: 350,
      width: 350,
      // padding: const EdgeInsets.all(16),
      child: totalAllExpenses == 0
          ? const Center(child: Text('Chưa có dữ liệu chi tiêu'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!
                                      .touchedSectionIndex;
                                });
                              },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: _buildChartSections(totalAllExpenses),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total all expenses: ${totalAllExpenses.toStringAsFixed(3)} VNĐ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      for (BucketExpense item in widget.buckets)
                        Text(
                          'Total by ${item.category.name}: ${item.total.toStringAsFixed(3)} VNĐ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: _getCategoryColor(item.category),
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  List<PieChartSectionData> _buildChartSections(double totalAllExpenses) {
    return List.generate(widget.buckets.length, (i) {
      final bucket = widget.buckets[i];
      final isTouched = i == touchedIndex;

      final percentage = totalAllExpenses > 0
          ? (bucket.total / totalAllExpenses) * 100
          : 0.0;

      final radius = isTouched ? 60.0 : 50.0;
      final fontSize = isTouched ? 16.0 : 12.0;

      return PieChartSectionData(
        color: _getCategoryColor(bucket.category),
        value: bucket.total,
        title: '${bucket.category.name} ${percentage.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    });
  }

  Color _getCategoryColor(Category category) {
    switch (category) {
      case Category.eat:
        return Colors.redAccent;
      case Category.maintance:
        return Colors.blueAccent;
      case Category.learn:
        return Colors.orangeAccent;
      case Category.skincare:
        return Colors.greenAccent;
    }
  }
}
