import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

class MainProvider with ChangeNotifier {
  int currentField = 0;
  List<String> userInput = [];
  bool gameReady = false;

  void init() {
    for (int i = 0; i < 2; i++) {
      userInput.add("0");
    }
  }

  void setCurrentField(int n) {
    this.currentField = n;
    notifyListeners();
  }

  void clear() {
    userInput.clear();
    notifyListeners();
  }

  void setUserInput(int i, String n) {
    this.userInput.insert(i, n);
    notifyListeners();
  }

  void setIsGameReady(bool n) {
    this.gameReady = n;
    notifyListeners();
  }

  bool isGameReady() {
    return gameReady;
  }

  void equalPressed(int i) {
    String finalUserInput = userInput[i];
    finalUserInput = userInput[i].replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userInput[i] = eval.toString();
    notifyListeners();
  }
}
