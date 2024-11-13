import 'package:flutter/material.dart';

class Dino extends StatefulWidget {
  final int dinoSpriteCount;
  final dinoDirection;
  // final double dinoX;
  // final double dinoY;

  const Dino({
    super.key,
    required this.dinoSpriteCount,
    // required this.dinoX,
    // required this.dinoY,
    required this.dinoDirection,
  }); // initial dinoY position});

  @override
  State<Dino> createState() => _DinoState();
}

class _DinoState extends State<Dino> {
  @override
  Widget build(BuildContext context) {
    if (widget.dinoDirection == 'jump') {
      return SizedBox(
        // alignment: Alignment(widget.dinoX, widget.dinoY),
        width: 150,
        child: Image.asset('Assets/png/Jump/Jump${widget.dinoSpriteCount}.png'),
      );
    } else {
      return SizedBox(
        // alignment: Alignment(widget.dinoX, widget.dinoY),
        width: 150,
        child: Image.asset('Assets/png/Run/run${widget.dinoSpriteCount}.png'),
      );
    }
  }
}
