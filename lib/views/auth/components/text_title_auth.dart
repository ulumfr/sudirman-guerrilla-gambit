import 'package:flutter/material.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';

class TextTitleAuth extends StatelessWidget {
  const TextTitleAuth({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Global.primaryColor,
        fontSize: 35,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
