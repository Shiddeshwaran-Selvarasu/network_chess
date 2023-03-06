import 'package:flutter/material.dart';

class JoiningPage extends StatefulWidget {
  const JoiningPage({Key? key}) : super(key: key);

  @override
  State<JoiningPage> createState() => _JoiningPageState();
}

class _JoiningPageState extends State<JoiningPage> {
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
