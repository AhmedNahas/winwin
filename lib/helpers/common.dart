import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Icon randomIcon() {
  final List<IconData> iconData = <IconData>[
    Icons.call,
    Icons.school,
    Icons.face,
    Icons.manage_accounts,
    Icons.catching_pokemon,
    Icons.videogame_asset_outlined
  ];
  final Random r = Random();

  return Icon(
    iconData[r.nextInt(iconData.length)],
    color: Colors.deepOrange,
  );
}
