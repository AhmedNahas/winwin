import 'dart:developer';

import 'package:flutter/material.dart';

Widget playerScoreTextField(
    {required controller, required onTab, required label, obscure = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      showCursor: true,
      readOnly: true,
      controller: controller,
      obscureText: obscure,
      onTap: onTab,
      onFieldSubmitted: (String value) {
        print('value is onFieldSubmitted : $value');
      },
      onChanged: (String value) {
        print('value is should be : $value');
      },
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
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
      onFieldSubmitted: (String value) {
        log(value);
      },
      onChanged: (String value) {
        log(value);
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
        style: Theme.of(context).textTheme.titleMedium,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: actions,
    );
