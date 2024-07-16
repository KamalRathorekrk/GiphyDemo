import 'package:demo21/authentication/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(emailController.text.isNotEmpty&&passwordController.text.isNotEmpty ){
                   authController.signIn(emailController.text, passwordController.text);
                }else{
                  Get.snackbar(
                      'Error',
                       "Please enter the email & password");
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Get.to(SignUpPage());
              },
              child: Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      )),
    );
  }
}
