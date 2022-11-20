import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';

class MainProvider with ChangeNotifier {
  List<String> currentPlayerFieldList = [];
  String currentPlayerField = "";
  late String selectedGame;
  late String playerCount;
  final List<String> gamesList = ['Domino', 'Tawla', 'PS'];
  late Map<String, List<String>> bbbbb = {
    "Domino": ['2', '3', '4'],
  };
  final List<String> playersCountList = ['2', '3', '4'];
  bool gameReady = false;

  // void init() {
  //   for (int i = 0; i < 2; i++) {
  //     //how many players
  //     userInput.add("0");
  //   }
  // }

  set setCurrentField(String n) {
    this.currentPlayerField = n;
    notifyListeners();
  }

  void notify() => notifyListeners();

  get getCurrentPlayerField => currentPlayerField;

  get getCurrentPlayersFieldList => currentPlayerFieldList;

  void setIsGameReady(bool n) {
    this.gameReady = n;
    notifyListeners();
  }

  bool isGameReady() {
    return gameReady;
  }

  void equalPressed(String i) {
    String finalUserInput =
        currentPlayerFieldList[int.parse(currentPlayerField)];
    finalUserInput = currentPlayerFieldList[int.parse(currentPlayerField)]
        .replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    var intV = eval.toInt();
    currentPlayerFieldList[int.parse(currentPlayerField)] = intV.toString();
    notifyListeners();
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  set setSelectedGame(String s) {
    this.selectedGame = s;
    notifyListeners();
  }

  String get getSelectedGame => selectedGame;

  List<String> get getGamesList => gamesList;

  set setPlayersCount(String s) {
    this.playerCount = s;
    notifyListeners();
  }

  String get getPlayersCount => playerCount;

  List<String> get getPlayersCountList => playersCountList;
}
