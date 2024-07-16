import 'package:demo21/authentication/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var user = Rxn<User>();
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    user.bindStream(_authService.auth.authStateChanges());
    super.onInit();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _authService.registerWithEmailAndPassword(email, password);
      Get.back();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
