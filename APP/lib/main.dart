import 'package:crypto_pass/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'forms/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splashScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: GestureDetector(
          onTap: () {
            // FocusScopeNode currentFocus = FocusScope.of(context);
            // if (!currentFocus.hasPrimaryFocus) {
            //   currentFocus.unfocus();
            // }
            FocusScope.of(context).unfocus();
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Crypto Pass',
            home: MyHomePage(),
          ),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
