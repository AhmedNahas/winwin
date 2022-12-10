import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/helpers/common.dart';
import 'package:winwin/helpers/reusable_component.dart';
import 'package:winwin/model/game_model.dart';
import 'package:winwin/model/player_info.dart';
import 'package:winwin/provider/main_provider.dart';
import 'package:winwin/screens/game_screen.dart';

import '../helpers/constants.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  String title;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var read = context.read<MainProvider>();
    return Scaffold(
      appBar: defaultAppBar(
        title: title,
        context: context,
        showLeading: false,
        onTab: null,
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
                style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
              ),
            ],
          ),
          onTap: () {
            Game game = Game(
                gameType: read.getGamesList[0],
                playersCount: read.getPlayersCountList[0],
                gameIcon: randomIcon(),
                winnersCount: 0,
                gameStatus: Status.ONGOING);
            read.game = game;
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
                  height: 500.0,
                  width: 400.0,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        gameType(cx),
                        playersNumber(cx),
                        gameEnd(cx),
                        sizedBoxHeightTen(),
                        playersNames(cx),
                        sizedBoxHeightTen(),
                        okayButton(cx),
                      ],
                    ),
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
          value: watch.game!.gameType,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: read.getGamesList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {
            read.game!.gameType = _!;
            read.notify();
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
        DropdownButton<int>(
          value: read.game!.playersCount,
          items: read.getPlayersCountList.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          onChanged: (_) {
            read.game!.playersCount = _!;
            read.getGameEndControllers!.clear();
            read.notify();
          },
        ),
      ],
    );
  }

  Widget gameEnd(BuildContext cx) {
    var read = cx.read<MainProvider>();
    return Container(
      height: 150.0,
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: Colors.black,
          )),
      child: GridView.builder(
          itemCount: read.game!.playersCount == 2
              ? 1
              : read.game!.playersCount == 3
                  ? 2
                  : 3,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisExtent: 60.0),
          itemBuilder: (BuildContext context, int i) {
            read.gameEndControllers(TextEditingController());
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: defaultTextFormField(
                controller: read.getGameEndControllers![i],
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter when game ends";
                  }
                  return null;
                },
                inputType: TextInputType.number,
                label: "Game end ${i + 1}",
                icon: const Icon(Icons.videogame_asset),
              ),
            );
          }),
    );
  }

  Widget okayButton(BuildContext cx) {
    var read = cx.read<MainProvider>();
    return defaultButton(
      width: double.infinity,
      background: Colors.blue,
      onPress: () {
        if (formKey.currentState!.validate()) {
          List<Player> players = <Player>[];
          List<int> gameEnds = <int>[];
          for (int i = 0; i < read.game!.playersCount; i++) {
            players.add(new Player(
                playerName: read.getNamesControllers[i].text,
                currentScore: 0,
                playerIcon: randomIcon(),
                controller: TextEditingController(text: "0")));
          }
          var length = read.getGameEndControllers!.length;
          for (int x = 0; x < length; x++) {
            var text = read.getGameEndControllers![x].text;
            gameEnds.add(int.parse(text));
          }
          read.game!.playersList = players;
          read.game!.gameEnd = gameEnds;
          Navigator.pop(cx);
          Navigator.push(
              cx, MaterialPageRoute(builder: (context) => GameScreen()));
        }
      },
      label: 'Ok',
      textColor: Colors.white,
    );
  }

  Widget playersNames(BuildContext cx) {
    var read = cx.read<MainProvider>();
    return Container(
      height: 100.0,
      width: 400.0,
      child: GridView.builder(
          itemCount: read.game!.playersCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 50.0),
          itemBuilder: (BuildContext context, int i) {
            read.namesControllers(TextEditingController());
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: defaultTextFormField(
                controller: read.getNamesControllers[i],
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter valid name";
                  }
                  return null;
                },
                inputType: TextInputType.text,
                label: "Name",
                icon: const Icon(Icons.face),
              ),
            );
          }),
    );
  }
}
