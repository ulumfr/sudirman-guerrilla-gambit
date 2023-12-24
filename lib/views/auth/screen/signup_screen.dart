import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';
import 'package:sudirman_guerrilla_gambit/controllers/auth/auth_controller.dart';
import 'package:sudirman_guerrilla_gambit/views/auth/components/text_auth.dart';
import 'package:sudirman_guerrilla_gambit/views/auth/components/text_field_auth.dart';
import 'package:sudirman_guerrilla_gambit/views/auth/components/text_title_auth.dart';

class SignupScreen extends GetView<AuthController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.gray1Color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 25),
                const TextTitleAuth(text: "SignUp Game"),
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
                      const SizedBox(height: 22),
                      const TextAuth(
                        labelText: "Confirm Password",
                        fontweight: FontWeight.w500,
                      ),
                      const SizedBox(height: 8),
                      TextFieldAuth(
                        controller: controller.confPasswordController,
                        obsecureText: controller.isSecure,
                        hintText: "enter your confirm password",
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: controller.isLoading.value
                            ? null
                            : () {
                                controller.registerUserFirebase(
                                  username:
                                      controller.nameController.text.trim(),
                                  email: controller.emailController.text.trim(),
                                  password:
                                      controller.passwordController.text.trim(),
                                  confPassword: controller
                                      .confPasswordController.text
                                      .trim(),
                                );
                              },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Global.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "SignUp",
                                    style: TextStyle(
                                      color: Global.gray1Color,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Global.gray3Color,
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        controller.goLogin();
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Global.primaryColor,
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
        ),
      ),
    );
  }
}