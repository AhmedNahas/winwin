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
    var watch = context.watch<MainProvider>();

    return Scaffold(
        appBar: defaultAppBar(
          title: read.game!.gameType,
          context: context,
          showLeading: true,
          onTab: () {
            read.clearAll();
            Navigator.pop(context);
          },
        ), //AppBar
        backgroundColor: Colors.black,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 400.0,
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: read.game!.playersCount,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int i) {
                    return playersCardDomino(
                      controller: watch.game!.playersList[i].controller,
                      onTextTab: () {
                        if (read.game!.gameStatus != Status.OVER) {
                          if (read.game!.playersList[i].getStatus !=
                              Status.WINNER) {
                            if (read.game!.playersList[read.getFocusedItem]
                                    .getStatus !=
                                Status.WINNER) {
                              read.game!.playersList[read.getFocusedItem]
                                  .setColor(Colors.black);
                            }
                            read.setFocusedItem = i;
                            read.game!.playersList[i].setColor(Colors.grey);
                            read.setTappedNumber("Score");
                            calcBottomSheet(context, read);
                          }
                        }
                      },
                      player: read.game!.playersList[i],
                      context: context,
                    );
                  }),
            ),
          ],
        ));
  }

  Future<void> calcBottomSheet(context, MainProvider read) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.green,
              ),
              child: Text(context.watch<MainProvider>().getTappedNum),
            ),
            Container(
              height: 300.0,
              color: Colors.black,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, right: 70.0, left: 70.0),
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 5.0,
                        crossAxisCount: 3,
                        mainAxisExtent: 60),
                    itemBuilder: (BuildContext context, int index) {
                      return buttons[index].isEmpty
                          ? SizedBox()
                          : MyButton(
                              buttontapped: () {
                                String num = read.getTappedNum;
                                if (num.compareTo("Score") == 0) {
                                  num = "";
                                }
                                var value = num += buttons[index];
                                read.setTappedNumber(value);
                              },
                              buttonText: buttons[index],
                              textColor: Colors.white,
                            );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: defaultButton(
                  width: 200.0,
                  background: Colors.green,
                  textColor: Colors.white,
                  onPress: () {
                    if (context
                            .read<MainProvider>()
                            .getTappedNum
                            .toString()
                            .compareTo("Score") !=
                        0) {
                      calculate(context, read);
                    }
                  },
                  label: "Ok"),
            )
          ],
        );
      },
    );
  }

  void calculate(context, MainProvider read) {
    int i = read.getFocusedItem;
    var g = read.game!;
    var currentScore = g.playersList[i].currentScore;
    var newScore = int.parse(read.getTappedNum);
    var finalScore = currentScore + newScore;
    g.playersList[i].controller.text = finalScore.toString();
    g.playersList[i].currentScore = finalScore;
    read.setTappedNumber("");

    whenGameEnds(g, i);

    read.notify();
    Navigator.pop(context);
  }

  void whenGameEnds(g, i) {
    var gameEnd = g.gameEnd[0];
    if (g.winnersCount == 0) {
      gameEnd = g.gameEnd[0];
    } else if (g.winnersCount == 1) {
      gameEnd = g.gameEnd[1];
    } else if (g.winnersCount == 2) {
      gameEnd = g.gameEnd[2];
    }
    checkTheWinner(g, i, gameEnd);
  }

  void checkTheWinner(g, i, gameEnd) {
    if (g.playersList[i].currentScore >= gameEnd) {
      g.playersList[i].setStatus = Status.WINNER;
      g.winnersCount += 1;
      whoIsTheWinner(g);
    }
  }

  void whoIsTheWinner(g) {
    switch (g.playersCount) {
      case 2:
        twoPlayerCheck(g);
        break;
      case 3:
        threePlayerCheck(g);
        break;
      case 4:
        fourPlayerCheck(g);
        break;
    }
  }

  void twoPlayerCheck(g) {
    for (int x = 0; x < g.playersCount; x++) {
      if (g.playersList[x].getStatus == Status.WINNER) {
        g.playersList[x].setColor(Colors.green);
        g.gameStatus = Status.OVER;
      } else {
        g.playersList[x].setStatus = Status.LOSER;
        g.playersList[x].setColor(Colors.red);
      }
    }
  }

  void threePlayerCheck(g) {
    for (int x = 0; x < g.playersCount; x++) {
      if (g.playersList[x].getStatus == Status.WINNER) {
        g.playersList[x].setColor(Colors.green);
      } else {
        if (g.winnersCount == 2) {
          g.playersList[x].setStatus = Status.LOSER;
          g.playersList[x].setColor(Colors.red);
          g.gameStatus = Status.OVER;
        }
      }
    }
  }

  void fourPlayerCheck(g) {
    for (int x = 0; x < g.playersCount; x++) {
      if (g.playersList[x].getStatus == Status.WINNER) {
        g.playersList[x].setColor(Colors.green);
      } else {
        if (g.winnersCount == 3) {
          g.playersList[x].setStatus = Status.LOSER;
          g.playersList[x].setColor(Colors.red);
          g.gameStatus = Status.OVER;
        }
      }
    }
  }
}
