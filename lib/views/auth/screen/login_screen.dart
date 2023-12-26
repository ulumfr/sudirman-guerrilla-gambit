import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:sudirman_guerrilla_gambit/constants.dart';
import 'package:sudirman_guerrilla_gambit/controllers/auth/auth_controller.dart';
import 'package:sudirman_guerrilla_gambit/views/auth/components/text_auth.dart';
import 'package:sudirman_guerrilla_gambit/views/auth/components/text_field_auth.dart';
import 'package:sudirman_guerrilla_gambit/views/auth/components/text_title_auth.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  Global.caveBg,
                  fit: BoxFit.cover,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.transparent
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    const TextTitleAuth(text: "Login Game"),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          const TextAuth(
                            labelText: "Email",
                            fontweight: FontWeight.w500,
                          ),
                          const SizedBox(height: 8),
                          TextFieldAuth(
                            controller: controller.emailController,
                            obsecureText: false,
                            hintText: "enter your email",
                          ),
                          const SizedBox(height: 22),
                          const TextAuth(
                            labelText: "Password",
                            fontweight: FontWeight.w500,
                          ),
                          const SizedBox(height: 8),
                          TextFieldAuth(
                            controller: controller.passwordController,
                            obsecureText: controller.isSecure,
                            hintText: "enter your password",
                          ),
                          const SizedBox(height: 25),
                          GestureDetector(
                            onTap: controller.isLoading.value
                                ? null
                                : () {
                                    controller.loginUserFirebase(
                                      controller.emailController.text,
                                      controller.passwordController.text,
                                    );
                                  },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Global.bgGoldGame,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "LogIn",
                                        style: TextStyle(
                                          color: Global.gray1Color,
                                          fontSize: 20,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have account?",
                                style: TextStyle(
                                  color: Global.bgBlackGame,
                                ),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  controller.goSignup();
                                },
                                child: const Text(
                                  "SignUp",
                                  style: TextStyle(
                                    color: Global.bgGoldGame,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
