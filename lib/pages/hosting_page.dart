import 'package:flutter/material.dart';

class HostingPage extends StatefulWidget {
  const HostingPage({
    Key? key,
    required this.boardColor,
    required this.pieceColor,
  }) : super(key: key);

  final int boardColor;
  final int pieceColor;

  @override
  State<HostingPage> createState() => _HostingPageState();
}

class _HostingPageState extends State<HostingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Network Chess'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
