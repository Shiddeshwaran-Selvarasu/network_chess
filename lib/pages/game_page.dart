import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:network_chess/widgets/loading_animation.dart';
import 'package:square_bishop/square_bishop.dart';
import 'package:squares/squares.dart';
import 'package:bishop/bishop.dart' as bishop;

class GamePage extends StatefulWidget {
  const GamePage({
    Key? key,
    required this.boardColor,
    required this.pieceColor,
  }) : super(key: key);

  final int boardColor;
  final int pieceColor;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late bishop.Game game;
  late SquaresState state;
  bool aiThinking = false;
  bool flipBoard = false;
  int moveCount = 0;

  List<BoardTheme> boards = [
    BoardTheme.brown,
    BoardTheme.blueGrey,
    BoardTheme.dart,
    BoardTheme.pink,
  ];

  @override
  void initState() {
    if (widget.pieceColor == Squares.black) {
      aiMove();
    }
    _resetGame(false);
    super.initState();
  }

  void _resetGame([bool ss = true]) {
    game = bishop.Game(variant: bishop.Variant.standard());
    state = game.squaresState(widget.pieceColor);
    if (ss) setState(() {});
  }

  void _flipBoard() => setState(() => flipBoard = !flipBoard);

  void _onMove(Move move) async {
    moveCount = 0;
    bool result = game.makeSquaresMove(move);
    if (result) {
      setState(() => state = game.squaresState(widget.pieceColor));
    }
    if (game.gameOver) {
      print('game Over');
    }
    if (state.state == PlayState.theirTurn && !aiThinking) {
      await aiMove();
    }
  }

  Future<void> aiMove() async {
    moveCount++;
    setState(() => aiThinking = true);
    await Future.delayed(Duration(milliseconds: Random().nextInt(4750) + 1000));
    game.makeRandomMove();
    setState(() {
      aiThinking = false;
      state = game.squaresState(widget.pieceColor);
    });
  }

  showAlert(var context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Row(
            children: const [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 25,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text("Discard game?"),
              ),
            ],
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          content: const Text(
            "Are sure you want to leave the game your progress will be deleted",
          ),
          actionsAlignment: MainAxisAlignment.end,
          elevation: 5,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Leave",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showAlert(context);
          },
        ),
        title: const Text('AI Chess'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          aiThinking
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: MediaQuery.of(context).size.width * 0.4,
                      ),
                      child: const ColorLoader(
                        dotRadius: 10,
                        radius: 25,
                      ),
                    ),
                  ),
                )
              : SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                  border: Border.all(color: Colors.black, width: 5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BoardController(
                    state: flipBoard ? state.board.flipped() : state.board,
                    playState: state.state,
                    pieceSet: PieceSet.merida(),
                    theme: boards[widget.boardColor],
                    moves: state.moves,
                    onMove: _onMove,
                    onPremove: _onMove,
                    markerTheme: MarkerTheme(
                      empty: MarkerTheme.dot,
                      piece: MarkerTheme.corners(),
                    ),
                    promotionBehaviour: PromotionBehaviour.autoPremove,
                    animatePieces: true,
                    animationDuration: const Duration(milliseconds: 1000),
                    animationCurve: Curves.linear,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!aiThinking) {
            setState(() {
              game.undo();
              game.undo();
              state = game.squaresState(widget.pieceColor);
            });
          }
        },
        child: const Icon(Icons.undo),
      ),
    );
  }
}
