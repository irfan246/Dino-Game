import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game2/gameScreen.dart';

void main() {
  runApp(const App());
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Gamescreen(),
    );
  }
}
