import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gcp/models/user.dart';
import 'package:gcp/screens/authentificate/authentificate_screen.dart';
import 'package:gcp/screens/splashscreen_wrapper.dart';
import 'package:gcp/services/authentification.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthentificationService().user,
      initialData: null,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashscreenWrapper()),
    );
  }
}
