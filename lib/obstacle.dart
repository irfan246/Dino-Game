import 'package:flutter/material.dart';

class Obstacle extends StatefulWidget {
  final String Image;

  Obstacle({required this.Image});

  @override
  State<Obstacle> createState() => _ObstacleState();
}

class _ObstacleState extends State<Obstacle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(widget.Image),
      width: 70,
    );
  }
}
