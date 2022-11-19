import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/provider/main_provider.dart';

import 'helpers/my_button.dart';
import 'helpers/reusable_component.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<MainProvider>(
          create: (BuildContext context) => MainProvider(),
          child: MyHomePage(title: 'WinWin')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
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
  String gameType = "Domino";
  String players = "2";
  bool _isEditingText = false;
  late TextEditingController _editingController;
  List<TextEditingController> _list = [];
  String initialText = "151";
  final String title;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    provider.init();
    _editingController = TextEditingController(text: provider.userInput[0]);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ), //AppBar
      backgroundColor: Colors.black,
      body: provider.isGameReady()
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: GridView.builder(
                        itemCount: 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int i) {
                          _list[provider.currentField].text =
                              provider.userInput[i];
                          return playersField(
                              controller: _list[provider.currentField],
                              onTab: () {
                                print("taaaaaaaaaaaaaaaaaaaaaaaaaaaaaaped $i");
                                provider.setCurrentField(i);
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
                                  provider.clear();
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
                                  provider.setUserInput(
                                      index,
                                      provider.userInput[provider
                                          .currentField] += buttons[index]);
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
                                  provider.setUserInput(
                                      provider.currentField,
                                      provider.userInput[provider.currentField]
                                          .substring(0,
                                              provider.userInput.length - 1));
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
                                  provider.equalPressed(provider.currentField);
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
                                  provider.setUserInput(
                                      provider.currentField,
                                      provider.userInput[provider
                                          .currentField] += buttons[index]);
                                },
                                buttonText: buttons[index],
                                color: isOperator(buttons[index])
                                    ? Colors.blueAccent
                                    : Colors.white,
                                textColor: isOperator(buttons[index])
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
              child: Text(
                'Tap on add new game!',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
      floatingActionButton: provider.isGameReady()
          ? null
          : FloatingActionButton(
              onPressed: () {
                showPrefDialog(context, provider);
              },
              tooltip: 'Dialog',
              child: Icon(Icons.add),
            ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void showPrefDialog(BuildContext context, MainProvider provider) {
    showDialog(
        context: context,
        builder: (bu) => AlertDialog(
              title: Text('Preferences'),
              content: Container(
                height: 300.0,
                child: Column(
                  children: [
                    Text('Game type'),
                    DropdownButton<String>(
                      value: gameType,
                      items:
                          <String>['Domino', 'Tawla', 'PS'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {
                        gameType = _!;
                      },
                    ),
                    Text('No of players'),
                    DropdownButton<String>(
                      value: "2",
                      items: <String>['2', '3', '4'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {
                        players = _!;
                      },
                    ),
                    Text('Game end'),
                    _editTitleTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          provider.setIsGameReady(true);
                          Navigator.pop(context);
                          for (int i = 0; i < 2; i++) {
                            _list.add(TextEditingController(
                                text:
                                    provider.userInput[provider.currentField]));
                          }
                        },
                        child: Text("OK"))
                  ],
                ),
              ),
            ));
  }

  Widget _editTitleTextField() {
    if (_isEditingText) {
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            initialText = newValue;
            _isEditingText = false;
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    } else {
      return InkWell(
          onTap: () {
            _isEditingText = true;
          },
          child: Text(
            initialText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ));
    }
  }
}
