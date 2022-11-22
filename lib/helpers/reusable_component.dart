import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget playersCard(
    {required controller, required onTab, required context, required label}) {
  final List<IconData> iconData = <IconData>[
    Icons.call,
    Icons.school,
    Icons.face,
    Icons.manage_accounts,
    Icons.catching_pokemon,
    Icons.videogame_asset_outlined
  ];
  final Random r = Random();
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              CircleAvatar(
                radius: 18.0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: CircleAvatar(
                  radius: 15.0,
                  child: Icon(iconData[r.nextInt(iconData.length)]),
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
                          labelText: label,
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
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
      ],
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
      onFieldSubmitted: (String value) {
        //log(value);
      },
      onChanged: (String value) {
        //log(value);
      },
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: actions,
    );
