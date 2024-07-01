import 'package:cat_trader/src/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();

// Ideal time to initialize
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Collector',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 66, 66, 66),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 246, 248, 255),
          onSecondary: const Color.fromARGB(255, 240, 242, 250),
          onSurface: const Color.fromARGB(255, 66, 66, 66),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 246, 248, 255),
        // scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      home: const LoginScreen(), //TODO implement login page
    );
  }
}
