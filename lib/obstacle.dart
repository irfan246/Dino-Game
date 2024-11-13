import 'package:flutter/material.dart';

class Obstacle extends StatefulWidget {
  final String Image;

  const Obstacle({super.key, required this.Image});

  @override
  State<Obstacle> createState() => _ObstacleState();
}

class _ObstacleState extends State<Obstacle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Image.asset(widget.Image),
    );
  }
}
