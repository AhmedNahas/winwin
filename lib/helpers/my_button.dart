import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // declaring variables
  final textColor;
  final String buttonText;
  final buttontapped;

  //Constructor
  MyButton({this.textColor, required this.buttonText, this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: ClipRRect(
        child: Container(
          child: CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.deepOrangeAccent,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
