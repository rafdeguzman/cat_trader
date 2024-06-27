import 'package:cat_trader/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
          onSurface: const Color.fromARGB(255, 66, 66, 66),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 246, 248, 255),
        // scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      home: const LoginScreen(), //TODO implement login page
    );
  }
}
