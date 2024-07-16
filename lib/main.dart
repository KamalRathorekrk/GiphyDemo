import 'package:demo21/authentication/login_page.dart';
import 'package:demo21/favourite_screen/favourite_screen_controller.dart';
import 'package:demo21/home_screen/home_screen.dart';
import 'package:demo21/home_screen/home_screen_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'authentication/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController(),);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        return authController.user.value == null ? LoginPage() : HomeScreen();
      }),
    );
  }
}
