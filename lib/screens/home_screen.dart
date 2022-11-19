import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/helpers/my_button.dart';
import 'package:winwin/helpers/reusable_component.dart';
import 'package:winwin/provider/main_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  String players = "2";
  late TextEditingController reachedGameEndController;
  List<TextEditingController> controllersList = [];
  final String title;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<MainProvider>(context);
    // provider.init();
    reachedGameEndController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ), //AppBar
      backgroundColor: Colors.black,
      body: context.watch<MainProvider>().isGameReady()
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: GridView.builder(
                        itemCount: int.parse(
                            context.read<MainProvider>().getPlayersCount),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int i) {
                          return playerScoreTextField(
                              controller: controllersList[i],
                              onTab: () {
                                context.read<MainProvider>().setCurrentField =
                                    i.toString();
                                print(
                                    "current Player ${context.read<MainProvider>().getCurrentPlayerField}");
                                controllersList[i].text = context
                                    .read<MainProvider>()
                                    .getCurrentPlayersFieldList[i];
                              },
                              label: "Whooo");
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
                                  crossAxisCount: 4, mainAxisExtent: 50),
                          itemBuilder: (BuildContext context, int index) {
                            // Clear Button
                            if (index == 0) {
                              return MyButton(
                                buttontapped: () {
                                  context
                                          .read<MainProvider>()
                                          .getCurrentPlayersFieldList[
                                      context
                                          .read<MainProvider>()
                                          .getCurrentPlayerField] = "";
                                  controllersList[int.parse(context
                                          .read<MainProvider>()
                                          .getCurrentPlayerField)]
                                      .text = context
                                          .read<MainProvider>()
                                          .getCurrentPlayersFieldList[
                                      int.parse(context
                                          .read<MainProvider>()
                                          .getCurrentPlayerField)];
                                  context.read<MainProvider>().notify();
                                },
                                buttonText: buttons[index],
                                color: Colors.blue[50],
                                textColor: Colors.black,
                              );
                            }

                            // +/- button
                            else if (index == 1) {
                              return MyButton(
                                buttonText: buttons[index],
                                color: Colors.blue[50],
                                textColor: Colors.black,
                              );
                            }
                            // % Button
                            else if (index == 2) {
                              return MyButton(
                                buttontapped: () {
                                  context
                                              .read<MainProvider>()
                                              .currentPlayerFieldList[
                                          context
                                              .read<MainProvider>()
                                              .getCurrentPlayerField] +=
                                      buttons[index];
                                  context.read<MainProvider>().notify();
                                },
                                buttonText: buttons[index],
                                color: Colors.blue[50],
                                textColor: Colors.black,
                              );
                            }
                            // Delete Button
                            else if (index == 3) {
                              return MyButton(
                                buttontapped: () {
                                  context
                                      .read<MainProvider>()
                                      .currentPlayerFieldList[int.parse(context
                                          .read<MainProvider>()
                                          .getCurrentPlayerField)]
                                      .substring(
                                          0,
                                          context
                                                  .read<MainProvider>()
                                                  .currentPlayerFieldList[
                                                      int.parse(context
                                                          .read<MainProvider>()
                                                          .getCurrentPlayerField)]
                                                  .length -
                                              1);
                                  controllersList[int.parse(context
                                          .read<MainProvider>()
                                          .getCurrentPlayerField)]
                                      .text = context
                                          .read<MainProvider>()
                                          .getCurrentPlayersFieldList[
                                      int.parse(context
                                          .read<MainProvider>()
                                          .getCurrentPlayerField)];
                                  context.read<MainProvider>().notify();
                                },
                                buttonText: buttons[index],
                                color: Colors.blue[50],
                                textColor: Colors.black,
                              );
                            }
                            // Equal_to Button
                            else if (index == 18) {
                              return MyButton(
                                buttontapped: () {
                                  context.read<MainProvider>().equalPressed(
                                      context
                                              .read<MainProvider>()
                                              .currentPlayerFieldList[
                                          int.parse(context
                                              .read<MainProvider>()
                                              .getCurrentPlayerField)]);
                                  controllersList[int.parse(context
                                          .read<MainProvider>()
                                          .getCurrentPlayerField)]
                                      .text = context
                                          .read<MainProvider>()
                                          .getCurrentPlayersFieldList[
                                      int.parse(context
                                          .read<MainProvider>()
                                          .getCurrentPlayerField)];
                                  context.read<MainProvider>().notify();
                                },
                                buttonText: buttons[index],
                                color: Colors.orange[700],
                                textColor: Colors.white,
                              );
                            }

                            //  other buttons
                            else {
                              return MyButton(
                                buttontapped: () {
                                  context
                                              .read<MainProvider>()
                                              .currentPlayerFieldList[
                                          int.parse(context
                                              .read<MainProvider>()
                                              .getCurrentPlayerField)] +=
                                      buttons[index];
                                  controllersList[int.parse(context
                                          .read<MainProvider>()
                                          .getCurrentPlayerField)]
                                      .text = context
                                          .read<MainProvider>()
                                          .getCurrentPlayersFieldList[
                                      int.parse(context
                                          .read<MainProvider>()
                                          .getCurrentPlayerField)];
                                  context.read<MainProvider>().notify();
                                },
                                buttonText: buttons[index],
                                color: context
                                        .watch<MainProvider>()
                                        .isOperator(buttons[index])
                                    ? Colors.blueAccent
                                    : Colors.white,
                                textColor: context
                                        .watch<MainProvider>()
                                        .isOperator(buttons[index])
                                    ? Colors.white
                                    : Colors.black,
                              );
                            }
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
                  context.read<MainProvider>().setSelectedGame =
                      context.read<MainProvider>().getGamesList[0];
                  context.read<MainProvider>().setPlayersCount =
                      context.read<MainProvider>().getPlayersCountList[0];
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
                              cx
                                  .read<MainProvider>()
                                  .currentPlayerFieldList
                                  .add("");
                              controllersList.add(TextEditingController(
                                  text: cx
                                      .read<MainProvider>()
                                      .currentPlayerFieldList[i]));
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
