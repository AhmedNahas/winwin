import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winwin/model/player_info.dart';

Widget playersCard(
    {required controller,
    required onTab,
    required context,
    required PlayerInfo player}) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), color: player.getColor()),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            CircleAvatar(
              radius: 18.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: CircleAvatar(
                radius: 15.0,
                child: player.playerIcon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Column(
                children: [
                  Container(
                    width: 170.0,
                    child: TextFormField(
                      controller: controller,
                      onTap: onTab,
                      autofocus: false,
                      focusNode: FocusNode(canRequestFocus: false),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: player.playerName,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.green,
                        child: Text("Win"),
                      ),
                      SizedBox(
                        width: 70.0,
                      ),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.red,
                        child: Text("lose"),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget defaultTextFormField(
        {required controller,
        required String? Function(String? v) validate,
        required inputType,
        required label,
        required icon,
        suffix,
        obscure = false}) =>
    TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscure,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        suffixIcon: suffix,
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  required double width,
  required Color background,
  required Color textColor,
  required Function()? onPress,
  required String label,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: onPress,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );

AppBar defaultAppBar(
        {required BuildContext context,
        String? title,
        List<Widget>? actions,
        required bool showLeading}) =>
    AppBar(
      leading: showLeading
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            )
          : null,
      title: Text(
        title!,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      actions: actions,
    );

Widget sizedBoxHeightTen() => SizedBox(
      height: 10.0,
    );
