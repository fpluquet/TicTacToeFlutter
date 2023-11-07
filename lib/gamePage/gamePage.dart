import 'package:flutter/material.dart';
import 'package:tictactoe/gamePage/gameButton.dart';

class GamePage extends StatefulWidget {
  static const String routeName = '/game';
  const GamePage({super.key, required this.title});

  final String title;

  @override
  State<GamePage> createState() => _GamePageState();
}

enum Player { X, O, NONE }

class _GamePageState extends State<GamePage> {
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
        automaticallyImplyLeading: true,
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
                  (index) => GameButton(
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
          if (isFull && !hasWinner)
            const Text(
              'Draw!',
              style: TextStyle(
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
          TextButton(
              onPressed: () => Navigator.pop(context, "J'ai quitté !"),
              child: const Text("Stop game"))
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
