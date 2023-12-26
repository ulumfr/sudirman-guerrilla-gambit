import 'package:flutter/material.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Global.gray1Color,
      body: Center(
        child: Text(
          "Sudirman Guerrilla",
          style: TextStyle(
            color: Global.textColor,
            fontSize: 70,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
