import 'package:get/get.dart';

class WelcomeScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAndToNamed('/login');
    });
  }
}