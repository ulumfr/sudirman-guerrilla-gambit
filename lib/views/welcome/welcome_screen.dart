import 'package:flutter/material.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Game",
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 70,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}