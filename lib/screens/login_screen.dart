import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sjcet_leave/screens/home_screen.dart';
import '../provider/signinController.dart';
import 'signup_screen.dart';
import '../utils/android_icon.dart';
import '../utils/mybtn.dart';
import '../utils/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Consumer<SignInController>(builder: (context, signin, child) {
          final emailController = signin.emailcontroller;
          final passwordController = signin.passwordcontroller;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const AndroidIcon(),
                MyTextField(
                  hint: 'Email',
                  obscureText: false,
                  color: Colors.white.withOpacity(0.5),
                  controller: emailController,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  hint: 'Password',
                  obscureText: true,
                  color: Colors.white.withOpacity(0.5),
                  controller: passwordController,
                ),
                const SizedBox(height: 25),
                Btn(
                    btntext: 'Sign in',
                    onpressed: () async {
                      FocusScope.of(context).unfocus();
                      try {
                        await signin
                            .signIn(
                                emailController.text, passwordController.text)
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>  Home()))));
                      } on FirebaseAuthException catch (e) {
                        emailController.clear();
                        passwordController.clear();
                        String errorMessage =
                            'An error occurred, please try again later.';
                        if (e.code == 'user-not-found') {
                          errorMessage =
                              'No user found with that email address.';
                        } else if (e.code == 'wrong-password') {
                          errorMessage =
                              'Wrong password provided for that user.';
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage)));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'An error occurred, please try again later.')));
                      }
                    }),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Not a member?',
                          style: TextStyle(fontSize: 16)),
                      GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          child: const Text('Register now',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}