import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game2/dino.dart';
import 'package:game2/obstacle.dart';

class Gamescreen extends StatefulWidget {
  const Gamescreen({super.key});

  @override
  State<Gamescreen> createState() => _GamescreenState();
}

class _GamescreenState extends State<Gamescreen> {
  int dinoSpriteCount = 1;
  double dinoPosX = -0.1;
  double dinoPosY = 1;
  double time = 0;
  double height = 0;
  double gravity = -4.9;
  double velocity = 6;
  double initialHeight = 0;
  bool isGameStarted = false;
  bool isGameOver = false;
  String dinoDirection = 'run';

  List<double> obstaclePosition = [1];
  double obstacleSpeed = 0.03;

  Timer? jumpTimer;
  Timer? moveTimer;
  Timer? obstacleTimer;

  void preJump() {
    time = 0;
    initialHeight = dinoPosY;
    dinoDirection = 'jump';
  }

  void dinoJump() {
    if (isGameOver) return;
    preJump();
    jumpTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = gravity * time * time + velocity * time;

      setState(() {
        if (initialHeight - height > 1) {
          dinoPosY = 1;
          dinoDirection = 'run';
          timer.cancel();
        } else {
          dinoPosY = initialHeight - height;
        }
      });
    });
  }

  void startGame() {
    if (!isGameStarted && !isGameOver) {
      isGameStarted = true;
      dinoDirection = 'run';
      moveDino();
      moveObstacle();
    } else if (isGameStarted && dinoDirection == 'run') {
      dinoJump();
    }
  }

  void moveDino() {
    moveTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (isGameOver) {
        timer.cancel();
        return;
      }

      setState(() {
        if (dinoDirection == 'run') {
          dinoSpriteCount++;
          if (dinoSpriteCount >= 8) {
            dinoSpriteCount = 1;
          }
        } else if (dinoDirection == 'jump') {
          dinoSpriteCount++;
          if (dinoSpriteCount >= 8) {
            dinoSpriteCount = 1;
          }
        }
      });

      for (double obstacleX in obstaclePosition) {
        if ((obstacleX - dinoPosX).abs() < 0.05 && dinoPosY > 0.9) {
          gameOver();
          break;
        }
      }
    });
  }

  void moveObstacle() {
    obstacleTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (isGameOver) {
        timer.cancel();
        return;
      }
      setState(() {
        for (int i = 0; i < obstaclePosition.length; i++) {
          obstaclePosition[i] -= 0.05;

          // Reset posisi rintangan dan tambahkan rintangan baru setelah dilewati
          if (obstaclePosition[i] < -1.2) {
            obstaclePosition[i] = 1.0;
          }

          // Tambahkan rintangan baru setelah posisi dilewati
          if (obstaclePosition[i] < -0.6 && obstaclePosition.length < 3) {
            obstaclePosition.add(1.0 + i * 0.4); // Posisi baru
          }
        }
      });
    });
  }

  void gameOver() {
    setState(() {
      isGameOver = true;
      isGameStarted = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    moveTimer?.cancel();
    jumpTimer?.cancel();
    obstacleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isGameOver) {
          setState(() {
            // Reset game
            isGameOver = false;
            dinoPosX = -0.8;
            dinoPosY = 1;
            obstaclePosition = [1.0];
          });
          startGame();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Stack(children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  alignment: Alignment(dinoPosX, dinoPosY),
                  child: Dino(
                    dinoSpriteCount: dinoSpriteCount,
                    dinoDirection: dinoDirection,
                  ),
                ),
                for (int i = 0; i < obstaclePosition.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment: Alignment(obstaclePosition[i], 6),
                    child: Obstacle(
                      Image: 'Assets/png/small_wood/small_wood_spike_04.png',
                    ),
                  ),
                if (isGameOver)
                  const Center(
                    child: Text(
                      'Game Over',
                      style: TextStyle(fontSize: 36, color: Colors.red),
                    ),
                  ),
              ]),
            ),
            SizedBox(
              height: 20,
              child: Container(
                color: Colors.green,
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              color: Colors.brown,
            ))
          ],
        ),
      ),
    );
  }
}
