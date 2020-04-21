import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flame/flame.dart';
import 'package:flame/text_config.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' as material;
import 'bullet.dart';
import 'dragon.dart';
import 'main.dart';

class Galaxy extends BaseGame {
  bool checkOnce = true;

  List<Dragon> dragonList = <Dragon>[];
  List<Bullet> bulletList = <Bullet>[];
  Size dimenstions;

  Galaxy(this.dimenstions);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    String text = points.toString();
    print("the point is"+text);


    TextPainter p = TextConfig(color: material.Colors.white, fontSize: 48.0, fontFamily: 'Halo').toTextPainter(text);

    String over = "Game over";
    TextPainter overGame = TextConfig(color: material.Colors.white, fontSize: 48.0, fontFamily: 'Halo').toTextPainter(over);
    gameOver
        ? overGame.paint(canvas, Offset(size.width / 5, size.height / 2))
        : p.paint(canvas,
            new Offset(size.width - p.width - 10, size.height - p.height - 10));
  }

  double creationTimer = 0.0;
  @override
  void update(double t) {
    creationTimer += t;
    if (creationTimer >= 4) {
      creationTimer = 0.0;

      for (int i = 1; i <= DRAGON_SIZE / 7; i++) {
        for (int j = 0; j < i; ++j) {
          dragon = new Dragon(dimenstions, i, j);
          dragonList.add(dragon);
          add(dragon);
        }
      }
    }
    super.update(t);
  }

  void tapInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    bulletStartStop = true;
    bulletList.add(bullet);
    bullet = new Bullet(dragonList, bulletList);
    add(bullet);
  }

  void dragInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    bulletStartStop = true;
  }

  void onUp() {
    bulletStartStop = false;
  }
}