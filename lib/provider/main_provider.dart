import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/game_model.dart';

class MainProvider with ChangeNotifier {
  late Game? _currentGame;
  int _focusedItem = 0;
  String _tappedNum = "Score";
  final List<String> _gamesList = ['Domino', 'Tawla', 'PS'];
  final List<int> _playersCountList = [2, 3, 4];
  List<TextEditingController>? _namesControllers = [];
  List<TextEditingController>? _gameEndControllers = [];

  set game(Game? game) {
    this._currentGame = game;
  }

  Game? get game => _currentGame;

  set setFocusedItem(int n) {
    this._focusedItem = n;
    notify();
  }

  get getFocusedItem => _focusedItem;

  void namesControllers(TextEditingController con) =>
      _namesControllers!.add(con);

  get getNamesControllers => _namesControllers;

  void gameEndControllers(TextEditingController con) {
    _gameEndControllers!.add(con);
  }

  List<TextEditingController>? get getGameEndControllers => _gameEndControllers;

  List<String> get getGamesList => _gamesList;

  List<int> get getPlayersCountList => _playersCountList;

  void setTappedNumber(String v) {
    this._tappedNum = v;
    notify();
  }

  get getTappedNum => _tappedNum;

  void notify() => notifyListeners();

  void clearAll() {
    _currentGame = null;
    _focusedItem = 0;
    _tappedNum = "Score";
    _namesControllers = [];
    _gameEndControllers = [];
  }

  @override
  void dispose() {
    clearAll();
    super.dispose();
  }
}
