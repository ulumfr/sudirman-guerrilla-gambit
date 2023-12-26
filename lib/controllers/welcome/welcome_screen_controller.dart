import 'package:get/get.dart';
import 'package:sudirman_guerrilla_gambit/controllers/auth/auth_controller.dart';

class WelcomeScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.put(AuthController());
    });
  }
}