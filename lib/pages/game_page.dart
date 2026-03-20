import 'dart:math';

import 'package:cluck_catch/components/fail_dialog.dart';
import 'package:cluck_catch/models/chicken.dart';
import 'package:cluck_catch/models/egg.dart';
import 'package:cluck_catch/provider/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  final ScoreProvider scoreProvider = Get.find<ScoreProvider>();
  int eggs = 0;
  int lives = 3;
  Rect player = Rect.fromLTWH(100, Get.height - 100, 200, 50);
  List<Chicken> chickens = [
    Chicken(spawnDelay: Duration.zero, rect: Rect.fromLTWH(0, 100, 100, 100)),
    Chicken(spawnDelay: 5.seconds, rect: Rect.fromLTWH(-50, 100, 100, 100)),
    Chicken(spawnDelay: 10.seconds, rect: Rect.fromLTWH(-50, 100, 100, 100)),
  ];
  List<Egg> fallingEggs = [];

  late final Ticker _ticker;
  @override
  void initState() {
    super.initState();
    _ticker = createTicker((dur) => onTick(dur));
    _ticker.start();
    gyroscopeEventStream().listen((data) => _movePlayer(data));
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            player = Rect.fromLTWH(
              details.globalPosition.dx,
              Get.height - 100,
              200,
              50,
            );
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/background.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 24,
              right: 24,
              child: Row(
                spacing: 12,
                children: [
                  for (int i = 0; i < 3; i++)
                    Transform.flip(
                      flipX: true,
                      child: Image.asset(
                        i >= lives
                            ? "assets/images/heard_open.png"
                            : "assets/images/heard_filled.png",
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              top: 24,
              left: 24,
              child: Text(
                "Eggs: $eggs",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: player.top,
              width: player.width,
              left: player.left,
              child: Image.asset("assets/images/eggbox.png"),
            ),
            for (var i = 0; i < fallingEggs.length; i++)
              Positioned(
                width: fallingEggs[i].rect.width,
                left: fallingEggs[i].rect.left,
                top: fallingEggs[i].rect.top,
                height: fallingEggs[i].rect.height,
                child: Image.asset(
                  fallingEggs[i].isRotten
                      ? "assets/images/egg_green.png"
                      : "assets/images/egg_white.png",
                ),
              ),
            for (var i = 0; i < 3; i++)
              if (chickens[i].showChicken)
                Positioned(
                  top: 150,
                  width: chickens[i].rect.width,
                  height: chickens[i].rect.height,
                  left: chickens[i].rect.left,
                  child: Transform.flip(
                    flipX: chickens[i].goesToLeft,
                    child: Image.asset("assets/images/chicken.gif"),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  void onTick(Duration dur) {
    for (var i = 0; i < 3; i++) {
      Chicken chicken = chickens[i];
      if (dur.inSeconds > chicken.spawnDelay.inSeconds) {
        if (!chicken.goesToLeft) {
          chicken = chicken.copyWith(rect: chicken.rect.shift(Offset(5, 0)));
          chickens[i] = chicken.copyWith(
            rect: chicken.rect.shift(Offset(5, 0)),
          );
        } else {
          chicken = chicken.copyWith(rect: chicken.rect.shift(Offset(-5, 0)));
          chickens[i] = chicken.copyWith(
            rect: chicken.rect.shift(Offset(-5, 0)),
          );
        }

        if (chicken.rect.left < 49) {
          chicken = chicken.copyWith(goesToLeft: false);
          chickens[i] = chicken.copyWith(goesToLeft: false);
        }
        if (chicken.rect.right > Get.width - 50) {
          chicken = chicken.copyWith(goesToLeft: true);
          chickens[i] = chicken.copyWith(goesToLeft: true);
        }

        if (dur.inMilliseconds >
            (chicken.lastSpawnEgg.inMilliseconds +
                chicken.randomDelay * 1000)) {
          final rnd = Random();
          chicken = chicken.copyWith(
            randomDelay: rnd.nextInt(3) + 2,
            lastSpawnEgg: dur,
          );
          chickens[i] = chicken.copyWith(
            randomDelay: rnd.nextInt(3) + 2,
            lastSpawnEgg: dur,
          );
          bool isRotten = rnd.nextInt(9) == 0;
          bool isFaster = rnd.nextInt(2) == 0;

          fallingEggs.add(
            Egg(rect: chicken.rect, isRotten: isRotten, isFaster: isFaster),
          );
        }
        chickens[i] = chicken.copyWith(showChicken: true);
      }
    }
    for (var i = 0; i < fallingEggs.length; i++) {
      try {
        final Egg egg = fallingEggs[i];
        if (egg.rect.bottom < 50) {
          fallingEggs.removeAt(i);
          continue;
        }
        if (egg.rect.overlaps(player) && egg.isRotten) {
          lives--;
          fallingEggs.removeAt(i);
          continue;
        }
        if (egg.rect.overlaps(player)) {
          fallingEggs.removeAt(i);
          eggs++;
          continue;
        }
        fallingEggs[i] = egg.copyWith(
          rect: egg.isFaster
              ? egg.rect.shift(Offset(0, 10))
              : egg.rect.shift(Offset(0, 5)),
        );
      } catch (e) {}
    }

    if (lives <= 0) {
      _ticker.stop();
      Get.dialog(FailDialog(eggs: eggs, onTap: resetGame));
    }
    setState(() {});
  }

  void resetGame() {
    eggs = 0;
    lives = 3;
    player = Rect.fromLTWH(100, Get.height - 100, 200, 50);
    chickens = [
      Chicken(spawnDelay: Duration.zero, rect: Rect.fromLTWH(0, 100, 100, 100)),
      Chicken(spawnDelay: 10.seconds, rect: Rect.fromLTWH(200, 100, 100, 100)),
      Chicken(spawnDelay: 5.seconds, rect: Rect.fromLTWH(100, 100, 100, 100)),
    ];
    fallingEggs = [];
    Get.back();
    if (_ticker.isActive) {
      _ticker.stop();
    }
    _ticker.start();
  }

  void _movePlayer(GyroscopeEvent data) {
    player = player.shift(Offset(data.y * 20, 0));
  }
}
