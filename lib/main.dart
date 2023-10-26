import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Player { X, O, NONE }

class _MyHomePageState extends State<MyHomePage> {
  final List<Player> cases = List.generate(9, (index) => Player.NONE);

  String getPlayerText(Player player) {
    switch (player) {
      case Player.X:
        return 'X';
      case Player.O:
        return 'O';
      case Player.NONE:
        return '';
    }
  }

  Player currentPlayer = Player.X;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: SizedBox(
        width: 320,
        height: 320,
        child: GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: List.generate(
              9,
              (index) => TicTacToeButton(
                  index: index,
                  onPressed: cases[index] == Player.NONE
                      ? (index) {
                          playOn(index);
                        }
                      : null,
                  text: getPlayerText(cases[index]))),
        ),
      )),
    );
  }

  void playOn(int index) {
    setState(() {
      cases[index] = currentPlayer;
      currentPlayer = currentPlayer == Player.X ? Player.O : Player.X;
    });
  }
}

class TicTacToeButton extends StatelessWidget {
  final int index;

  final void Function(int index)? onPressed;

  final String text;

  const TicTacToeButton({
    super.key,
    required this.index,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        child: Text(text,
            style: const TextStyle(
              fontSize: 32,
            )),
        onPressed: onPressed != null
            ? () {
                onPressed!(index);
              }
            : null,
      ),
    );
  }
}
