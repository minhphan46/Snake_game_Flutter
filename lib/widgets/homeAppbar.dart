import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home),
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
