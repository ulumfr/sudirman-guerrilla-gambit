import 'package:get/get.dart';
import 'package:sudirman_guerrilla_gambit/views/welcome/welcome_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: '/welcome',
      page: () => const WelcomeScreen(),
      // binding: BindingsBuilder(() {

      // })
    ),
  ];
}
