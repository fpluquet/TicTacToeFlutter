import 'package:flutter/material.dart';
import 'package:tictactoe/gamePage/gamePage.dart';

class MenuPage extends StatefulWidget {
  static String routeName = '/menu';
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Menu'),
      ),
      body: Center(
        child: Wrap(
          spacing: 20, // to apply margin in the main axis of the wrap
          runSpacing: 20, // to apply margin in the cross axis of the wrap
          children: [
            ElevatedButton(
              onPressed: () async {
                var resultString = await Navigator.pushNamed(
                  context,
                  GamePage.routeName,
                );
                print(result);
                setState(() {
                  result = resultString as String?;
                });
              },
              child: const Text('Play'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Erreur !"),
                      content: const Text("Mon dieu, c'est une erreur !"),
                      actions: <Widget>[
                        // les boutons en bas du dialogue
                        TextButton(
                          child: const Text("Fermer"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Settings'),
            ),
            if (result != null) const Text("Quitter sans sauvegarder")
          ],
        ),
      ),
    );
  }
}
