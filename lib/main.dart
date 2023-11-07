import 'package:flutter/material.dart';
import 'package:tictactoe/gamePage/gamePage.dart';
import 'package:tictactoe/menuPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: MenuPage.routeName,
      routes: {
        MenuPage.routeName: (context) => const MenuPage(),
        GamePage.routeName: (context) => const GamePage(title: 'Tic Tac Toe'),
      },
    );
  }
}
