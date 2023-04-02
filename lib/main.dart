import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sjcet_leave/provider/access_storage.dart';
import 'package:sjcet_leave/provider/detailsControllers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_screen.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Home(),
      ),
    );
  }
}
