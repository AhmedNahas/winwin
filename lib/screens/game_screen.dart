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
          title: read.getSelectedGame,
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
                  itemCount: int.parse(read.getPlayersCount),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int i) {
                    return playersCardDomino(
                      controller: watch.getScoresControllersList[i],
                      onTab: () {
                        print("Players count : ${read.getPlayersCount}");
                      },
                      player: read.getPlayersList()[i],
                      context: context,
                      addBtn: () {
                        if (read.getCurrentTextField.compareTo("") != 0) {
                          read
                              .getPlayersList()[
                                  int.parse(read.getCurrentTextField)]
                              .setColor(Colors.black);
                        }
                        read.setCurrentTextField = i.toString();
                        read.getPlayersList()[i].setColor(Colors.grey);
                        read.setTappedNumber("Score");
                        calcBottomSheet(context, read);
                      },
                    );
                  }),
            ),
          ],
        ));
  }

  Future<void> calcBottomSheet(context, MainProvider read) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          Container(
            height: 350.0,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 70.0, left: 70.0),
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
                label: context.watch<MainProvider>().getTappedNum),
          )
        ]);
      },
    );
  }

  void calculate(context, MainProvider read) {
    int i = int.parse(read.getCurrentTextField);
    var currentScore = read.getPlayersList()[i].currentScore;
    var newScore = int.parse(read.getTappedNum);
    var finalScore = currentScore + newScore;
    read.getScoresControllersList[i].text = finalScore.toString();
    read.getPlayersList()[i].currentScore = finalScore;
    read.setTappedNumber("");
    if (read
            .getPlayersList()[int.parse(read.getCurrentTextField)]
            .currentScore >=
        151) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Wineeeeeeeeeeeeeeeeeeeeer")));
    }
    Navigator.pop(context);
  }
}
