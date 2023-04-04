import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sjcet_leave/screens/home_screen.dart';
import 'package:sjcet_leave/screens/login_screen.dart';
import 'package:sjcet_leave/provider/access_storage.dart';
import 'package:sjcet_leave/provider/detailsControllers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'provider/signUpController.dart';
import 'provider/signinController.dart';
import 'provider/signoutController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccessStorage()),
        ChangeNotifierProvider(create: (_) => DetailsController()),
        ChangeNotifierProvider(create: (_) => SignInController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => SignOutController()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, AsyncSnapshot<User?> streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return
                  const  Center(child: CircularProgressIndicator());
                } else if (streamSnapshot.hasData) {
                 return  Home();
                } else {
                  return const LoginPage();
                }
              })),
    );
  }
}
