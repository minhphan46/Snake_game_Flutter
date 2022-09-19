import 'package:flutter/material.dart';

class GridViewTable extends StatelessWidget {
  final int numberOfSquares;
  final List<int> snakePosition;
  final int food;
  final Color snakeColor;
  final Color foodColor;
  final Color backroundColor;
  GridViewTable({
    required this.numberOfSquares,
    required this.snakePosition,
    required this.food,
    this.snakeColor = Colors.white,
    this.foodColor = Colors.green,
    this.backroundColor = Colors.white10,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: numberOfSquares,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: (snakePosition.contains(index))
                      ? snakeColor
                      : ((index == food) ? foodColor : backroundColor),
                  /* child: Text(
                    '${index}',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      //fontSize: 1,
                    ),
                  ), */
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
