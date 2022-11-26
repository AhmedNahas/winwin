import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/helpers/common.dart';
import 'package:winwin/helpers/reusable_component.dart';
import 'package:winwin/model/player_info.dart';
import 'package:winwin/provider/main_provider.dart';
import 'package:winwin/screens/game_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  late TextEditingController reachedGameEndController;
  String title;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var read = context.read<MainProvider>();
    reachedGameEndController = TextEditingController();
    return Scaffold(
      appBar: defaultAppBar(
        title: title,
        context: context,
        showLeading: false,
      ), //AppBar
      backgroundColor: Colors.black,
      body: Center(
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                child: Image(
                  image: AssetImage('assets/images/domino.png'),
                ),
              ),
              Text(
                'Tap to add new game!',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          onTap: () {
            read.setSelectedGame = read.getGamesList[0];
            read.setPlayersCount = read.getPlayersCountList[0];
            showPrefDialog(context);
          },
        ),
      ),
    );
  }

  void showPrefDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (cx) => Form(
              key: formKey,
              child: AlertDialog(
                title: Text('Preferences'),
                content: Container(
                  height: 300.0,
                  child: Column(
                    children: [
                      gameType(cx),
                      playersNumber(cx),
                      gameEnd(),
                      sizedBoxHeightTen(),
                      okayButton(cx),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget gameType(BuildContext cx) {
    var read = cx.read<MainProvider>();
    var watch = cx.watch<MainProvider>();
    return Row(
      children: [
        Text('Game type'),
        SizedBox(
          width: 10.0,
        ),
        DropdownButton<String>(
          value: watch.getSelectedGame,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: read.getGamesList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {
            read.setSelectedGame = _!;
          },
        ),
      ],
    );
  }

  Widget playersNumber(BuildContext cx) {
    var read = cx.read<MainProvider>();
    return Row(
      children: [
        Text('No of players'),
        SizedBox(
          width: 10.0,
        ),
        DropdownButton<String>(
          value: read.getPlayersCount,
          items: read.getPlayersCountList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {
            read.setPlayersCount = _!;
          },
        ),
      ],
    );
  }

  Widget gameEnd() {
    return defaultTextFormField(
      controller: reachedGameEndController,
      validate: (String? value) {
        if (value!.isEmpty) {
          return "Please enter when game ends";
        }
      },
      inputType: TextInputType.number,
      label: "Game end",
      icon: const Icon(Icons.videogame_asset),
    );
  }

  Widget okayButton(BuildContext cx) {
    var read = cx.read<MainProvider>();
    return defaultButton(
      width: double.infinity,
      background: Colors.blue,
      onPress: () {
        if (formKey.currentState!.validate()) {
          for (int i = 0; i < int.parse(read.getPlayersCount); i++) {
            read.setPlayersList(new PlayerInfo(
                playerName: "Eid", currentScore: "", playerIcon: randomIcon()));
            read.setControllersList(TextEditingController(
                text: read.getPlayersList()[i].currentScore));
          }
          Navigator.pop(cx);
          Navigator.push(
              cx, MaterialPageRoute(builder: (context) => GameScreen()));
        }
      },
      label: 'Ok',
      textColor: Colors.white,
    );
  }
}
