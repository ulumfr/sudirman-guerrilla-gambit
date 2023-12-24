import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudirman_guerrilla_gambit/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Game Sudirman Guerrilla Gambit',
      initialRoute: '/welcome',
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
