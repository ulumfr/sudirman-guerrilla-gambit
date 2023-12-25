import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();

  RxBool isLoading = false.obs;
  bool isSecure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> registerUserFirebase({
    String? username,
    required String email,
    required String password,
    required String confPassword,
  }) async {
    try {
      isLoading.value = true;
      if (password != confPassword) {
        throw 'Password and Confirm Password must match';
      }
      await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // final user = userController.addUser(
      //   auth.currentUser!.uid,
      //   username,
      //   email,
      //   password,
      // );
      // userController.createUser(user);
      // await auth.currentUser!.updateDisplayName(username);
      // prefs.setString('user_token', auth.currentUser!.uid);
      Get.snackbar(
        'Success',
        'Registration Successful',
        backgroundColor: Global.primaryColor,
        colorText: Global.whiteColor,
      );
      // await Future.delayed(const Duration(seconds: 2)); // Ganti dengan durasi yang sesuai
      goLogin();
    } catch (error) {
      String errorMessage = 'Registration Failed';

      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'invalid-password':
            errorMessage = 'Password should be at least 6 characters long';
            break;
          case 'email-already-exists':
            errorMessage = 'The email is already in use by another account.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          default:
            errorMessage = '${error.message}';
        }
      } else if (error is String) {
        errorMessage = error;
      }
      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Global.secondaryColor,
        colorText: Global.whiteColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUserFirebase(String email, String password) async {
    try {
      isLoading.value = true;
      await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // prefs.setString('user_token', auth.currentUser!.uid);
      Get.snackbar(
        'Success',
        'Login Successful',
        backgroundColor: Global.primaryColor,
        colorText: Global.whiteColor,
      );
      goMenu();
    } catch (error) {
      Get.snackbar(
        'Error',
        'Login Failed: $error',
        backgroundColor: Global.secondaryColor,
        colorText: Global.whiteColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    try {
      isLoading.value = true;
      // prefs.remove('user_token');
      await auth.signOut();
      Get.snackbar(
        'Succes',
        'Logout Successful',
        backgroundColor: Global.primaryColor,
        colorText: Global.whiteColor,
      );
    } catch (error) {
      Get.snackbar(
        'Error',
        'Logout Failed: $error',
        backgroundColor: Global.secondaryColor,
        colorText: Global.whiteColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goLogin() {
    clear();
    Get.toNamed('/login');
  }

  void goSignup() {
    Get.toNamed('/signup');
  }

  void goMenu() {
    clear();
    Get.offAndToNamed('/menu');
  }

  void clear() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confPasswordController.clear();
  }
}
