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
  bool _gameReady = false;

  set setCurrentTextField(String n) {
    this._currentPlayerField = n;
    notifyListeners();
  }

  get getCurrentTextField => _currentPlayerField;

  void setPlayersList(PlayerInfo player) => _playersList.add(player);

  get getPlayersList => _playersList;

  void setIsGameReady(bool n) {
    this._gameReady = n;
    notifyListeners();
  }

  bool isGameReady() {
    return _gameReady;
  }

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
