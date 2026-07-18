import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_app/model/summary_result_item.dart';

class SummaryResultScreen extends StatelessWidget {
  final List<SummaryResultItem> summaryResults;

  const SummaryResultScreen(this.summaryResults, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            for (SummaryResultItem item in summaryResults)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: item.checkCorrectAnswer()
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                    child: Text(
                      (item.indexItem + 1).toString(),
                      style: TextStyle(
                        color: const Color.fromARGB(255, 104, 11, 73),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text(
                          item.questionText,
                          style: GoogleFonts.geist(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Your answered: ${item.userAnswered}',
                          style: GoogleFonts.geist(
                            color: const Color.fromARGB(255, 223, 186, 230),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          'Correct answer: ${item.answer}',
                          style: GoogleFonts.geist(
                            color: const Color.fromARGB(255, 212, 242, 223),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
