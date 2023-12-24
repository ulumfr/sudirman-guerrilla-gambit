import 'package:get/get.dart';
import 'package:sudirman_guerrilla_gambit/controllers/auth/auth_controller.dart';
import 'package:sudirman_guerrilla_gambit/controllers/welcome/welcome_screen_controller.dart';
import 'package:sudirman_guerrilla_gambit/views/auth/screen/login_screen.dart';
import 'package:sudirman_guerrilla_gambit/views/auth/screen/signup_screen.dart';
import 'package:sudirman_guerrilla_gambit/views/game/gambit.dart';
import 'package:sudirman_guerrilla_gambit/views/welcome/welcome_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: '/welcome',
      page: () => const WelcomeScreen(),
      binding: BindingsBuilder(() {
        Get.put(WelcomeScreenController());
      }),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: '/signup',
      page: () => const SignupScreen(),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut(() => AuthController());
      // }),
    ),
    GetPage(
      name: '/game',
      page: () => const Gambit(),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut(() => AuthController());
      // }),
    ),
  ];
}
