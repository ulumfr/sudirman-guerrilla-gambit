import 'package:flutter/material.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';

class TextAuth extends StatelessWidget {
  const TextAuth({
    Key? key,
    required this.labelText,
    required this.fontweight,
  }) : super(key: key);

  final String labelText;
  final FontWeight fontweight;

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: TextStyle(
        color: Global.bgwhiteColor,
        fontSize: 16,
        fontWeight: fontweight,
      ),
    );
  }
}