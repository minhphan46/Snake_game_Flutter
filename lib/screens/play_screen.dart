import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snake_game/widgets/gridView_table.dart';
import 'package:snake_game/widgets/homeAppbar.dart';
import 'gameOver_screen.dart';

class PlayScreen extends StatefulWidget {
  late Color backroundColor;
  PlayScreen({required this.backroundColor});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
//========== game specs ===================================
  static List<int> snakePosition = [45, 65, 85, 105, 125];
  static const int numberOfSquares = 680;
  static var randomNumber = Random();
  int food = randomNumber.nextInt(numberOfSquares);
  int speed = 300;
  var direction = 'down';
  bool begin = true;
  bool _enabled = true;
  bool _ispause = false;
  int score = (snakePosition.length - 5);
  Timer? timer;
  //Color backroundColor = Color(0xff1b263b);
  Color snakeColor = Colors.white;
  Color snakeHeadColor = Colors.teal;
  Color foodColor = Colors.green;
//========== Function of Game =============================
  void generateNewFood() {
    print(speed);
    do {
      food = randomNumber.nextInt(numberOfSquares);
    } while (snakePosition.contains(food));
  }

  void increaseDifficulty() {
    if (score % 2 == 0) {
      (speed > 20) ? (speed -= 10) : (speed = 10);
    }
  }

  void startGame() {
    if (!begin && !_ispause) return;
    snakePosition = [45, 65, 85, 105, 125];
    speed = 300;
    direction = 'down';
    _enabled = true;
    _ispause = false;
    final duration = Duration(milliseconds: speed);
    timer = Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _enabled = false;
        begin = true;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GameOverScreen(score, startGame)),
        );
      }
    });
  }

  void stopTime() {
    if (timer != null) {
      setState(() {
        timer!.cancel();
        timer = null;
        _ispause = true;
      });
    } else {
      _ispause = false;
      final duration = Duration(milliseconds: speed);
      timer = Timer.periodic(duration, (Timer timer) {
        updateSnake();
        if (gameOver()) {
          timer.cancel();
          _enabled = false;
          begin = true;
        }
      });
    }
  }

  void updateSnake() {
    if (begin) {
      direction = 'down';
      begin = false;
      _ispause = false;
    }
    setState(
      () {
        switch (direction) {
          case 'down':
            if (snakePosition.last >= (numberOfSquares - 20)) {
              int x = snakePosition.last % (numberOfSquares - 20);
              snakePosition.add(x);
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
          score++;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backroundColor,
      body: SafeArea(
        child: Column(
          children: [
            HomeAppbar(),
            Expanded(
              child: GestureDetector(
                //====== xu ly dieu khien ================
                onVerticalDragUpdate: _enabled && !_ispause
                    ? (details) {
                        if (direction != 'up' && details.delta.dy > 0) {
                          direction = 'down';
                        } else if (direction != 'down' &&
                            details.delta.dy < 0) {
                          direction = 'up';
                        }
                      }
                    : null,
                onHorizontalDragUpdate: _enabled && !_ispause
                    ? (details) {
                        if (direction != 'left' && details.delta.dx > 0) {
                          direction = 'right';
                        } else if (direction != 'right' &&
                            details.delta.dx < 0) {
                          direction = 'left';
                        }
                      }
                    : null,
                //========================================
                child: GridViewTable(
                  numberOfSquares: numberOfSquares,
                  food: food,
                  snakePosition: snakePosition,
                  snakeColor: snakeColor,
                  snakeHeadColor: snakeHeadColor,
                  foodColor: foodColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: (begin) ? Colors.transparent : Colors.white,
                          width: 2,
                        ),
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: (begin) ? null : stopTime,
                        icon: Icon(
                          (begin)
                              ? null
                              : ((timer != null)
                                  ? Icons.pause
                                  : Icons.play_arrow),
                        ),
                        color: Colors.white,
                        iconSize: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: startGame,
                      child: const Text(
                        'Start game',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
