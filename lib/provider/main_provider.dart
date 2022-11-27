import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winwin/model/player_info.dart';

class MainProvider with ChangeNotifier {
  List<PlayerInfo> _playersList = [];
  String _currentPlayerField = "";
  late String _selectedGame;
  late String _playerCount;
  String _tappedNum = "Score";
  final List<String> _gamesList = ['Domino', 'Tawla', 'PS'];
  final List<String> _playersCountList = ['2', '3', '4'];
  List<TextEditingController> _scoresControllersList = [];
  List<TextEditingController> _namesControllersList = [];

  void clearAll() {
    _playersList = [];
    _currentPlayerField = "";
    _selectedGame = "";
    _playerCount = "";
    _tappedNum = "Score";
    _scoresControllersList = [];
    _namesControllersList = [];
  }

  set setCurrentTextField(String n) {
    this._currentPlayerField = n;
    notify();
  }

  get getCurrentTextField => _currentPlayerField;

  void setPlayersList(PlayerInfo player) => _playersList.add(player);

  List<PlayerInfo> getPlayersList() => _playersList;

  void setScoresControllersList(TextEditingController con) =>
      _scoresControllersList.add(con);

  get getScoresControllersList => _scoresControllersList;

  void setNamesControllersList(TextEditingController con) =>
      _namesControllersList.add(con);

  get getNamesControllersList => _namesControllersList;

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

  void setTappedNumber(String v) {
    this._tappedNum = v;
    notify();
  }

  get getTappedNum => _tappedNum;

  void notify() => notifyListeners();

  @override
  void dispose() {
    clearAll();
    super.dispose();
  }
}
