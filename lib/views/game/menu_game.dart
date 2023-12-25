import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';

class MenuGame extends GetView<SudirmanGameController> {
  MenuGame({Key? key}) : super(key: key);

  final isloginUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/map/SudirmanAssets/example.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.transparent,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 100,
                  ),
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        'Welcome, ${isloginUser.email}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Global.whiteColor,
                        ),
                      ),
                      const Text(
                        'Sudirman Guerrilla',
                        style: TextStyle(
                          fontSize: 50,
                          color: Global.whiteColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.goGame();
                        },
                        child: const Text(
                          'Play',
                          style: TextStyle(
                            fontSize: 30,
                            color: Global.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
