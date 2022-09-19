import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snake_game/widgets/gridView_table.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//========== game specs ===================================
  static List<int> snakePosition = [45, 65, 85, 105, 125];
  static const int numberOfSquares = 680;
  static var randomNumber = Random();
  int food = randomNumber.nextInt(numberOfSquares);
  int speed = 300;
  Color backroundColor = Colors.black;
  var direction = 'down';
  bool begin = true;
  bool _enabled = true;
  int scorce = (snakePosition.length - 5);
  Timer? timer;
//========== Function of Game =============================
  void generateNewFood() {
    do {
      food = randomNumber.nextInt(numberOfSquares);
    } while (snakePosition.contains(food));
  }

  void increaseDifficulty() {
    if (scorce % 2 == 0) {
      (speed > 20) ? (speed -= 20) : (speed = 20);
    }
  }

  void startGame() {
    if (!begin) return;
    snakePosition = [45, 65, 85, 105, 125];
    speed = 300;
    var direction = 'down';
    _enabled = true;
    final duration = Duration(milliseconds: speed);
    timer = Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen();
        _enabled = false;
        begin = true;
      }
    });
  }

  void stopTime() {
    setState(() {
      timer!.cancel();
    });
  }

  void continueRuning() {
    final duration = Duration(milliseconds: speed);
    timer = Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen();
        _enabled = false;
        begin = true;
      }
    });
  }

  void updateSnake() {
    if (begin) {
      direction = 'down';
      begin = false;
    }
    setState(
      () {
        switch (direction) {
          case 'down':
            if (snakePosition.last >= (numberOfSquares - 20)) {
              int x = snakePosition.last % (numberOfSquares - 20);
              snakePosition.add(x);
              print('${snakePosition}');
            } else {
              snakePosition.add(snakePosition.last + 20);
            }
            break;
          case 'up':
            if (snakePosition.last < 20) {
              snakePosition.add(snakePosition.last - 20 + numberOfSquares);
            } else {
              snakePosition.add(snakePosition.last - 20);
            }
            break;
          case 'left':
            if (snakePosition.last % 20 == 0) {
              snakePosition.add(snakePosition.last - 1 + 20);
            } else {
              snakePosition.add(snakePosition.last - 1);
            }
            break;
          case 'right':
            if ((snakePosition.last + 1) % 20 == 0) {
              snakePosition.add(snakePosition.last + 1 - 20);
            } else {
              snakePosition.add(snakePosition.last + 1);
            }
            break;

          default:
        }

        if (snakePosition.last == food) {
          generateNewFood();
          scorce++;
          increaseDifficulty();
        } else {
          snakePosition.removeAt(0);
        }
      },
    );
  }

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count++;
        }
      }
      if (count == 2) {
        return true;
      }
    }
    return false;
  }

  void _showGameOverScreen() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('GAME OVER'),
          content: Text('Your score: ' + scorce.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  startGame();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Play Again',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backroundColor,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              //====== xu ly dieu khien ================
              onVerticalDragUpdate: _enabled
                  ? (details) {
                      if (direction != 'up' && details.delta.dy > 0) {
                        direction = 'down';
                      } else if (direction != 'down' && details.delta.dy < 0) {
                        direction = 'up';
                      }
                    }
                  : null,
              onHorizontalDragUpdate: _enabled
                  ? (details) {
                      if (direction != 'left' && details.delta.dx > 0) {
                        direction = 'right';
                      } else if (direction != 'right' && details.delta.dx < 0) {
                        direction = 'left';
                      }
                    }
                  : null,
              //========================================
              child: GridViewTable(
                numberOfSquares: numberOfSquares,
                food: food,
                snakePosition: snakePosition,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Score:  ${snakePosition.length - 5}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                /* TextButton(
                  onPressed: null,
                  //(begin) ? null : ((isRuning) ? stopTime : continueRuning),
                  child: Text(
                    (i.isActive) ? 'Pause' : 'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ), */
                TextButton(
                  onPressed: startGame,
                  child: const Text(
                    'Start game',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
