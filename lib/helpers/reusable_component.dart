import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget playersField({required controller, required label, obscure = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      showCursor: true,
      readOnly: true,
      autofocus: true,
      controller: controller,
      obscureText: obscure,
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
