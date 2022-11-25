import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/helpers/constants.dart';
import 'package:winwin/helpers/my_button.dart';
import 'package:winwin/helpers/reusable_component.dart';
import 'package:winwin/provider/main_provider.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var read = context.read<MainProvider>();
    return Scaffold(
        appBar: defaultAppBar(
          title: read.getSelectedGame,
          context: context,
          showLeading: true,
        ), //AppBar
        backgroundColor: Colors.black,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: int.parse(read.getPlayersCount),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int i) {
                      return playersCard(
                        controller: read.getControllersList[i],
                        onTab: () {
                          if (read.getCurrentTextField.compareTo("") != 0) {
                            read
                                .getPlayersList()[
                                    int.parse(read.getCurrentTextField)]
                                .setColor(Colors.black);
                          }
                          read.setCurrentTextField = i.toString();
                          read.getControllersList[i].text =
                              read.getPlayersList()[i].currentScore;
                          read.getPlayersList()[i].setColor(Colors.grey);
                        },
                        player: read.getPlayersList()[i],
                        context: context,
                      );
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 5.0,
                          crossAxisCount: 3,
                          mainAxisExtent: 60),
                      itemBuilder: (BuildContext context, int index) {
                        return buttons[index].isEmpty
                            ? Spacer()
                            : MyButton(
                                buttontapped: () {
                                  read
                                      .getPlayersList()[
                                          int.parse(read.getCurrentTextField)]
                                      .currentScore += buttons[index];
                                  read
                                          .getControllersList[int.parse(
                                              read.getCurrentTextField)]
                                          .text =
                                      read
                                          .getPlayersList()[int.parse(
                                              read.getCurrentTextField)]
                                          .currentScore;
                                  read.notify();
                                },
                                buttonText: buttons[index],
                                textColor: Colors.white,
                              );
                      }),
                ), // GridView.builder
              ),
            ),
          ],
        ));
  }
}
