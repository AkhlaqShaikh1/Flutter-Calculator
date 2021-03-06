import 'package:calculator/widgtes/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userInput = '';
  String userResult = '';
  List<String> buttons = [
    "C","DEL","%","/",
    "9","8","7","x",
    "6","5","4","-",
    "3","2","1","+",
    "0",".","ANS","="
  ];
  @override
  Widget build(BuildContext context) {
    // print(buttons[7]);
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: Text(
                  userInput,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(
                  userResult,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ],
          )),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: buttons.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                //clear
                if (index == 0) {
                  return clearButton(index);
                }
                //DEL
                else if (index == 1) {
                  return delButton(index);
                }
                //Equal
                else if (index == buttons.length - 1) {
                  return equalButton(index);
                }
                //ANS
                else if (index == buttons.length - 2) {
                  return ansButton(index);
                }
                //Rest of the buttons
                else {
                  return restOfTheButtons(index);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  CustomButton restOfTheButtons(int index) {
    return CustomButton(
      text: buttons[index],
      color: isOperator(buttons[index])
          ? Colors.deepPurple
          : Colors.deepPurple[50]!,
      textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
      buttonTapped: () {
        setState(() {
          userInput += buttons[index];
        });
      },
    );
  }

  CustomButton ansButton(int index) {
    return CustomButton(
      text: buttons[index],
      color: Colors.deepPurple,
      textColor: Colors.white,
      buttonTapped: () {
        setState(() {
          userInput = userResult;
        });
      },
    );
  }

  CustomButton equalButton(int index) {
    return CustomButton(
      text: buttons[index],
      color: Colors.deepPurple,
      textColor: Colors.white,
      buttonTapped: () {
        setState(() {
          result();
        });
      },
    );
  }

  CustomButton delButton(int index) {
    return CustomButton(
      text: buttons[index],
      color: Colors.red,
      textColor: Colors.white,
      buttonTapped: () {
        setState(() {
          userInput = userInput.substring(0, userInput.length - 1);
        });
      },
    );
  }

  CustomButton clearButton(int index) {
    return CustomButton(
      text: buttons[index],
      color: Colors.green,
      textColor: Colors.white,
      buttonTapped: () {
        setState(() {
          userInput = '';
          userResult = '';
        });
      },
    );
  }
  //Operators
  bool isOperator(String x) {
    if (x == '%' || x == "/" || x == "x" || x == "-" || x == "+" || x == "=")
      // ignore: curly_braces_in_flow_control_structures
      return true;

    return false;
  }
  //Logic of how things are working
  void result() {
    String finalInput = userInput;
    finalInput = finalInput.replaceAll("x", "*");
  
    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userResult = eval.toString();
  }
}
