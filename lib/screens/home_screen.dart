import 'package:flutter/material.dart';
import 'package:snake_game/screens/play_screen.dart';

class HomeScreen extends StatelessWidget {
  Color backroundColor = Color(0xff3EB2E5);
  HomeScreen(this.backroundColor);
  Widget Button(String name, Color color, VoidCallback ontap) {
    return Container(
      height: 60,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50), //radius cho widget
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50), //radius cho hiệu ứng
          onTap: ontap,
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            // game Name
            const SizedBox(height: 150),
            SizedBox(
              height: 200,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover, // chinh anh vua voi khung hinh
              ),
            ),
            const Text(
              "Snake Game",
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Play button
            const SizedBox(height: 35),
            Button(
              "Play",
              Color(0xffDF527D),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PlayScreen(backroundColor: backroundColor),
                  ),
                );
              },
            ),
            // setting Button
            const SizedBox(height: 17),
            Button("LeaderBoard", Color(0xffEEA42C), () {}),
            // xep hang
            const SizedBox(height: 17),
            Button("Setting", Color(0xff707070), () {}),
          ],
        ),
      ),
    );
  }
}
