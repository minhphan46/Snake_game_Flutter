import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  int score = 0;
  late Function restart;
  GameOverScreen(this.score, this.restart);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333333),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 250),
            const Text(
              "GAME OVER",
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your scores: $score',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 150),
            IconButton(
              onPressed: () {
                restart!();
                Navigator.pop(context);
              },
              iconSize: 50,
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Tap to Retry",
              style: TextStyle(
                color: Color(0xffC5C5C5),
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
