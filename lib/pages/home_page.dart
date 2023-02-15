import 'package:flutter/material.dart';
import 'package:network_chess/widgets/sliding_segmented.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int difficulty = 0;
  int  pieceColor = 0;
  int boardColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chess'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Center(
            child: Text(
              'Network Chess',
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Difficulty:'),
          ),
          SlidingSegmentedControl(
            myTabs: const {
              0: Text('Easy'),
              1: Text('Medium'),
              2: Text('Hard'),
            },
            selectIndex: difficulty,
            onValueChanged: (i){
              setState(() {
                difficulty = i ?? 0;
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Color:'),
          ),
          SlidingSegmentedControl(
            myTabs: const {
              0: Text('Black'),
              1: Text('White'),
            },
            selectIndex: pieceColor,
            onValueChanged: (i){
              setState(() {
                pieceColor = i ?? 0;
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Color:'),
          ),
          SlidingSegmentedControl(
            myTabs: const {
              0: Text('Black'),
              1: Text('White'),
            },
            selectIndex: boardColor,
            onValueChanged: (i){
              setState(() {
                boardColor = i ?? 0;
              });
            },
          ),
        ],
      ),
    );
  }
}
