import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MainProvider with ChangeNotifier {
  List<String> currentPlayerFieldList = [];
  String currentPlayerField = "";
  late String selectedGame;
  late String playerCount;
  final List<String> gamesList = ['Domino', 'Tawla', 'PS'];
  final List<String> playersCountList = ['2', '3', '4'];
  bool gameReady = false;

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
