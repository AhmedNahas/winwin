import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerInfo {
  late String playerName;
  late String currentScore;
  late Icon playerIcon;
  Color color = Colors.black;

  PlayerInfo(
      {required playerName, required currentScore, required playerIcon}) {
    this.playerName = playerName;
    this.currentScore = currentScore;
    this.playerIcon = playerIcon;
  }

  void setColor(color) => this.color = color;

  Color getColor() => color;
}
