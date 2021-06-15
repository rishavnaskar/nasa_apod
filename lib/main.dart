import 'package:dsc_project/FUNCTIONS/Auth.dart';
import 'package:dsc_project/FUNCTIONS/Components.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print('error');
        if (snapshot.connectionState == ConnectionState.done)
          return MaterialApp(
            title: 'Astronomy Picture of the Day',
            debugShowCheckedModeBanner: false,
            home: AuthService().handleAuth(),
          );
        return Components().kCircularProgressIndicator;
      },
    );
  }
}
