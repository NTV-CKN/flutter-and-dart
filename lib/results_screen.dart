import 'package:flutter/material.dart';
import 'package:second_app/questions_screen.dart';
import 'package:second_app/start_screen.dart';

// ignore: must_be_immutable
class ResultsScreen extends StatefulWidget {
  void Function()? onResultsScreenDispose;
  final void Function(Widget widget) navigate;

  ResultsScreen.navigate(
    this.navigate, {
    super.key,
    this.onResultsScreenDispose,
  });

  void setOnResultsSceenDispose(void Function() onResultsScreenDispose) {
    this.onResultsScreenDispose = onResultsScreenDispose;
  }

  @override
  State<StatefulWidget> createState() {
    return _ResultsScreenState();
  }
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeWidget = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        margin: EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Results'),
            SizedBox(
              height: 30,
            ),
            Text('List answers of you...'),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    widget.navigate.call(
                      QuestionScreen.navigate(widget.navigate),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(
                      sizeWidget - (sizeWidget * 0.7),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 42, 15, 193),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Icon(
                    Icons.restart_alt,
                  ),
                  label: Text('Restart Quiz!'),
                ),
                SizedBox(
                  width: 40,
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    widget.navigate.call(StartScreen(widget.navigate));
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size.fromWidth(
                      sizeWidget - (sizeWidget * 0.7),
                    ),
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: const Color.fromARGB(255, 42, 15, 193),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Icon(
                    Icons.exit_to_app,
                  ),
                  label: Text('Exit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //đảm bảo _ResultsScreenState không dùng setState, từ đó giúp ta dựa vào
    //dispose callback để reset danh sách
    widget.onResultsScreenDispose?.call();
    super.dispose();
  }
}
