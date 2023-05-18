import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWidget(),
    );
  }
}

//devDiariesWithVee on Instagram
//devDiariesWithVee on Youtube
//vaidehi2701 on Github

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final Map<String, bool> score = {};

  /// Choices for game
  final Map choices = {
    "💚 ": Colors.green,
    "💛": Colors.yellow,
    "❤️": Colors.red,
    "💜": Colors.purple,
    "🤎": Colors.brown,
  };

  int seed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        titleSpacing: 50,
        title: Text(
          'Score ${score.length}/5',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: choices.keys.map((e) {
              return Draggable<String>(
                data: e,
                feedback: Emoji(emoji: e),
                childWhenDragging: const Emoji(emoji: ''),
                child: Emoji(
                  emoji: score[e] == true ? "✅" : e,
                ),
                // Draggable
              );
            }).toList()),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              choices.keys.map((emoji) => _buildDragTarget(emoji)).toList()
                ..shuffle(Random(seed)),
        ),
      ]),
    );
  }

  Widget _buildDragTarget(emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List rejected) {
        if (score[emoji] == true) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            alignment: Alignment.center,
            height: 60,
            width: 100,
            child: const Text(
              'Correct !!!',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
        } else {
          return Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: choices[emoji],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Text(""),
          );
        }
      },
      onWillAccept: (data) => data == emoji,
      onAccept: (data) {
        setState(() {
          score[emoji] = true;
        });
      },
      onLeave: (data) {},
    );
  }
}

class Emoji extends StatelessWidget {
  const Emoji({super.key, required this.emoji});
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        padding: const EdgeInsets.all(10),
        child: Text(
          emoji,
          style: const TextStyle(color: Colors.black, fontSize: 30),
        ), // Text
      ),
    );
  }
}
