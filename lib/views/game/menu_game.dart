import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';
import 'package:sudirman_guerrilla_gambit/controllers/auth/auth_controller.dart';

class MenuGame extends StatelessWidget {
  MenuGame({Key? key}) : super(key: key);

  final AuthController conAuth = Get.find<AuthController>();
  final isloginUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Global.caveBg,
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
                          Get.offAndToNamed('/game');
                        },
                        child: const Text(
                          'Play',
                          style: TextStyle(
                            fontSize: 30,
                            color: Global.whiteColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/setting');
                        },
                        child: const Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 30,
                            color: Global.whiteColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          conAuth.logout();
                        },
                        child: const Text(
                          'Logout',
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
