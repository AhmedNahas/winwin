import 'package:flutter/material.dart';
import 'package:winwin/helpers/constants.dart';

class Player {
  late String playerName;
  late int currentScore;
  late Icon playerIcon;
  Status status = Status.ONGOING;
  Color color = Colors.black;
  late TextEditingController controller;
  late List<int> scoreList;

  Player(
      {required playerName,
      required currentScore,
      required playerIcon,
      required controller,
      required List<int> scoreList}) {
    this.playerName = playerName;
    this.currentScore = currentScore;
    this.playerIcon = playerIcon;
    this.controller = controller;
    this.scoreList = scoreList;
  }

  set setStatus(Status status) {
    this.status = status;
  }

  get getStatus => status;

  void setColor(color) => this.color = color;

  Color getColor() => color;
}
