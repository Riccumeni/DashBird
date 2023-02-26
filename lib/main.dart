import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

/// This example simply adds a rotating white square on the screen.
/// If you press on a square, it will be removed.
/// If you press anywhere else, another square will be added.
class MyGame extends FlameGame with TapDetector{
  SpriteComponent dash = new SpriteComponent();
  SpriteComponent background = new SpriteComponent();

  double gravity = 3;
  final double dashSize = 100;
  final double jumpForce = 140;
  Vector2 velocity = Vector2(0, 0);
  @override
  Future<void> onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];

    add(background
      ..sprite = await loadSprite('background.png')
      ..size = size
    );

    dash
      ..sprite = await loadSprite('dash.png')
      ..size = Vector2(dashSize, dashSize)
      ..y = screenHeight - dashSize - 400
      ..x = screenWidth - dashSize - 150;

    add(dash);
  }

  @override
  void update(double dt){
    super.update(dt);

    velocity.y += gravity;

    dash.position.y += velocity.y * dt;
  }

  @override
  bool onTapDown(TapDownInfo event) {
    print("Player tap down on ${event.eventPosition.game}");

    dash.y -= 10;
    velocity.y = -jumpForce;
    return true;
  }

}