import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:winwin/model/player_info.dart';

class MainProvider with ChangeNotifier {
  List<PlayerInfo> _playersList = [];
  String _currentPlayerField = "";
  late String _selectedGame;
  late String _playerCount;
  final List<String> _gamesList = ['Domino', 'Tawla', 'PS'];
  final List<String> _playersCountList = ['2', '3', '4'];
  List<TextEditingController> _controllersList = [];

  set setCurrentTextField(String n) {
    this._currentPlayerField = n;
    notify();
  }

  get getCurrentTextField => _currentPlayerField;

  void setPlayersList(PlayerInfo player) => _playersList.add(player);

  List<PlayerInfo> getPlayersList() => _playersList;

  void setControllersList(TextEditingController con) =>
      _controllersList.add(con);

  get getControllersList => _controllersList;

  set setSelectedGame(String s) {
    this._selectedGame = s;
    notifyListeners();
  }

  String get getSelectedGame => _selectedGame;

  List<String> get getGamesList => _gamesList;

  set setPlayersCount(String s) {
    this._playerCount = s;
    notifyListeners();
  }

  String get getPlayersCount => _playerCount;

  List<String> get getPlayersCountList => _playersCountList;

  void notify() => notifyListeners();
}
