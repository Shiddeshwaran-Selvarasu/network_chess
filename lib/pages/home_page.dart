import 'package:flutter/material.dart';
import 'package:network_chess/pages/game_page.dart';
import 'package:squares/squares.dart';

import '../widgets/sliding_segmented.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int difficulty = 0;
  int pieceColor = 0;
  int boardColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Chess'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Difficulty:'),
          ),
          SlidingSegmentedControl(
            tabs: const {
              0: Text('Easy'),
              1: Text('Medium'),
              2: Text('Hard'),
            },
            selectIndex: difficulty,
            onValueChanged: (i) {
              setState(() {
                difficulty = i ?? 0;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Piece Color:'),
          ),
          SlidingSegmentedControl(
            tabs: const {
              Squares.white: Text('White'),
              Squares.black: Text('Black'),
            },
            selectIndex: pieceColor,
            onValueChanged: (i) {
              setState(() {
                pieceColor = i ?? 0;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Board Color:'),
          ),
          SlidingSegmentedControl(
            tabs: const {
              0: Text('Brown'),
              1: Text('Blue Grey'),
              2: Text('Dart'),
              3: Text('Pink'),
            },
            selectIndex: boardColor,
            onValueChanged: (i) {
              setState(() {
                boardColor = i ?? 0;
              });
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                        boardColor: boardColor,
                        pieceColor: pieceColor,
                      ),
                    ),
                  );
                },
                child: const Text('Start'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
