import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:math_expressions/math_expressions.dart';

import '../../constants/mybutton.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  var userQuestion = '';
  var userAnswer = '';
  String ans = '';

  final List<String> buttons = [
    'AC',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  void showHistoryAlertDialog() {
    final historyBox = Hive.box('calcHistory');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                height: calculateDialogHeight(historyBox.length, context),
                child: ValueListenableBuilder(
                  valueListenable: historyBox.listenable(),
                  builder: (context, Box box, widget) {
                    if (box.isEmpty) {
                      return const Center(
                        child: Text('No calculation history available'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                box.getAt(index).toString()), // Display history
                          );
                        },
                      );
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  double calculateDialogHeight(int itemCount, BuildContext context) {
    const double minHeight = 100.0; // Minimum height of dialog
    const double maxHeightFactor = 0.8; // Max height factor (80%)
    const double itemHeight = 56.0; // Approximate height of each ListTile
    const double padding = 50.0; // Extra padding

    // Dynamic height based on item count
    double dialogHeight = itemCount * itemHeight + padding;
    double maxHeight = MediaQuery.of(context).size.height * maxHeightFactor;

    // Return a suitable height within min/max bounds
    return dialogHeight < minHeight
        ? minHeight
        : dialogHeight > maxHeight
            ? maxHeight
            : dialogHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 5000,
        onRefresh: () async {
          _clearAll();
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 110,
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box('calcHistory').listenable(),
                        builder: (context, Box box, widget) {
                          if (box.isEmpty) {
                            return const Center(
                              child: Text('No calculation history available'),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: box.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  trailing: IconButton(
                                    onPressed: () {
                                      showHistoryAlertDialog();
                                    },
                                    icon: const Icon(Icons.fullscreen),
                                  ),
                                  title: Text(
                                    box.getAt(index).toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          Text(
                            userAnswer,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.green,
                      textColor: Colors.white,
                    );
                  } else if (index == 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          if (userQuestion.isNotEmpty) {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          }
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white,
                    );
                  } else if (index == buttons.length - 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.grey,
                      textColor: Colors.white,
                    );
                  } else if (index == buttons.length - 2) {
                    return MyButton(
                      buttonText: 'ANS',
                      color: isOperator(buttons[index])
                          ? const Color.fromRGBO(188, 136, 93, 10)
                          : Color.fromRGBO(240, 240, 240, 1.0),
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                      buttonTapped: () {
                        setState(() {
                          userQuestion += ans;
                        });
                      },
                    );
                  } else {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.grey
                          : Color.fromRGBO(240, 240, 240, 1.0),
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    return ['%', '/', '-', '+', 'x', '='].contains(x);
  }

  void equalPressed() {
    String finalQuestion = userQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      userAnswer =
          eval == eval.toInt() ? eval.toInt().toString() : eval.toString();
      ans = userAnswer;

      // Save the calculation and result to Hive
      final historyBox = Hive.box('calcHistory');
      historyBox.add('$userQuestion = $userAnswer'); // Store as a string

      userQuestion = '';
    });
  }

  void _clearAll() {
    setState(() {
      userAnswer = '';
      userQuestion = '';
    });
  }
}
