import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winwin/model/player_info.dart';

import '../helpers/constants.dart';

class Game {
  late String gameType;
  late int playersCount;
  late List<int> _gameEnd;
  late Icon gameIcon;
  late int winnersCount;
  late List<Player> _playersList;
  late Status gameStatus;

  Game(
      {required this.gameType,
      required this.playersCount,
      required this.gameIcon,
      required this.winnersCount,
      required this.gameStatus});

  set gameEnd(List<int> gameEnd) => this._gameEnd = gameEnd;

  List<int> get gameEnd => _gameEnd;

  set playersList(List<Player> playersList) => this._playersList = playersList;

  List<Player> get playersList => _playersList;
}
