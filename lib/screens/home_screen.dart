import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/helpers/common.dart';
import 'package:winwin/helpers/my_button.dart';
import 'package:winwin/helpers/reusable_component.dart';
import 'package:winwin/model/player_info.dart';
import 'package:winwin/provider/main_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final List<String> buttons = [
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    '',
    '0',
    ''
  ];
  late TextEditingController reachedGameEndController;
  List<TextEditingController> controllersList = [];
  final String title;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var providerWatch = context.watch<MainProvider>();
    var providerRead = context.read<MainProvider>();
    reachedGameEndController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ), //AppBar
      backgroundColor: Colors.black,
      body: providerWatch.isGameReady()
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: GridView.builder(
                        itemCount: int.parse(providerRead.getPlayersCount),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int i) {
                          return playersCard(
                              controller: controllersList[i],
                              onTab: () {
                                if (providerRead.getCurrentTextField
                                        .compareTo("") !=
                                    0) {
                                  providerRead.getPlayersList[int.parse(
                                          providerRead.getCurrentTextField)]
                                      .setColor(Colors.black);
                                }
                                providerRead.setCurrentTextField = i.toString();
                                controllersList[i].text =
                                    providerRead.getPlayersList[i].currentScore;
                                providerRead.getPlayersList[i]
                                    .setColor(Colors.grey);
                              },
                              player: providerRead.getPlayersList[i],
                              context: context,
                              cardColor:
                                  providerRead.getPlayersList[i].getColor());
                        }),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: buttons.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 5.0,
                                  crossAxisCount: 3,
                                  mainAxisExtent: 60),
                          itemBuilder: (BuildContext context, int index) {
                            var prov = providerRead;
                            return buttons[index].isEmpty
                                ? Spacer()
                                : MyButton(
                                    buttontapped: () {
                                      prov
                                          .getPlayersList[int.parse(
                                              prov.getCurrentTextField)]
                                          .currentScore += buttons[index];
                                      controllersList[int.parse(
                                                  prov.getCurrentTextField)]
                                              .text =
                                          prov
                                              .getPlayersList[int.parse(
                                                  prov.getCurrentTextField)]
                                              .currentScore;
                                      prov.notify();
                                    },
                                    buttonText: buttons[index],
                                    textColor: Colors.white,
                                  );
                          }),
                    ), // GridView.builder
                  ),
                ),
              ],
            )
          : Center(
              child: InkWell(
                child: Text(
                  'Tap to add new game!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  providerRead.setSelectedGame = providerRead.getGamesList[0];
                  providerRead.setPlayersCount =
                      providerRead.getPlayersCountList[0];
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
                      Row(
                        children: [
                          Text('Game type'),
                          SizedBox(
                            width: 10.0,
                          ),
                          DropdownButton<String>(
                            value: cx.watch<MainProvider>().getSelectedGame,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: cx
                                .read<MainProvider>()
                                .getGamesList
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {
                              cx.read<MainProvider>().setSelectedGame = _!;
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('No of players'),
                          SizedBox(
                            width: 10.0,
                          ),
                          DropdownButton<String>(
                            value: cx.read<MainProvider>().getPlayersCount,
                            items: cx
                                .read<MainProvider>()
                                .getPlayersCountList
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {
                              cx.read<MainProvider>().setPlayersCount = _!;
                            },
                          ),
                        ],
                      ),
                      defaultTextFormField(
                        controller: reachedGameEndController,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter when game ends";
                          }
                        },
                        inputType: TextInputType.number,
                        label: "Game end",
                        icon: const Icon(Icons.videogame_asset),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultButton(
                        width: double.infinity,
                        background: Colors.blue,
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            cx.read<MainProvider>().setIsGameReady(true);
                            print("is game ready true");
                            Navigator.pop(cx);
                            for (int i = 0;
                                i <
                                    int.parse(cx
                                        .read<MainProvider>()
                                        .getPlayersCount);
                                i++) {
                              cx.read<MainProvider>().setPlayersList(
                                  new PlayerInfo(
                                      playerName: "Eid",
                                      currentScore: "",
                                      playerIcon: randomIcon()));
                              controllersList.add(TextEditingController(
                                  text: cx
                                      .read<MainProvider>()
                                      .getPlayersList[i]
                                      .currentScore));
                            }
                          }
                        },
                        label: 'Ok',
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
