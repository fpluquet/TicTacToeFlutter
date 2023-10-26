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

  bool get hasWinner => winner != Player.NONE;

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
  Player winner = Player.NONE;

  bool get isFull => cases.every((element) => element != Player.NONE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
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
                      onPressed: cases[index] == Player.NONE && !hasWinner
                          ? (index) {
                              playOn(index);
                            }
                          : null,
                      text: getPlayerText(cases[index]))),
            ),
          ),
          if (hasWinner)
            Text(
              '${getPlayerText(winner)} wins!',
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
          if (isFull)
            Text(
              'Draw!',
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
          if (hasWinner || isFull)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cases.fillRange(0, 9, Player.NONE);
                  winner = Player.NONE;
                });
              },
              child: const Text('Play again'),
            ),
          if (!hasWinner && !isFull)
            Text(
              'Current player: ${getPlayerText(currentPlayer)}',
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
        ],
      )),
    );
  }

  void playOn(int index) {
    setState(() {
      cases[index] = currentPlayer;
      currentPlayer = currentPlayer == Player.X ? Player.O : Player.X;
      winner = getWinner();
    });
  }

  Player getWinner() {
    if (cases[0] != Player.NONE &&
        cases[0] == cases[1] &&
        cases[1] == cases[2]) {
      return cases[0];
    }
    if (cases[3] != Player.NONE &&
        cases[3] == cases[4] &&
        cases[4] == cases[5]) {
      return cases[3];
    }
    if (cases[6] != Player.NONE &&
        cases[6] == cases[7] &&
        cases[7] == cases[8]) {
      return cases[6];
    }
    if (cases[0] != Player.NONE &&
        cases[0] == cases[3] &&
        cases[3] == cases[6]) {
      return cases[0];
    }
    if (cases[1] != Player.NONE &&
        cases[1] == cases[4] &&
        cases[4] == cases[7]) {
      return cases[1];
    }
    if (cases[2] != Player.NONE &&
        cases[2] == cases[5] &&
        cases[5] == cases[8]) {
      return cases[2];
    }
    if (cases[0] != Player.NONE &&
        cases[0] == cases[4] &&
        cases[4] == cases[8]) {
      return cases[0];
    }
    if (cases[2] != Player.NONE &&
        cases[2] == cases[4] &&
        cases[4] == cases[6]) {
      return cases[2];
    }
    return Player.NONE;
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
