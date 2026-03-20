import 'package:cluck_catch/models/chicken.dart';
import 'package:cluck_catch/models/egg.dart';
import 'package:cluck_catch/models/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  int eggs = 0;
  int lives = 3;
  Player player = Player(rect: Rect.fromLTWH(100, Get.height - 100, 200, 50));
  final List<Chicken> chickens = [
    Chicken(spawnDelay: Duration.zero, rect: Rect.fromLTWH(0, 100, 100, 100)),
    Chicken(spawnDelay: 5.seconds, rect: Rect.fromLTWH(0, 100, 100, 100)),
    Chicken(spawnDelay: 10.seconds, rect: Rect.fromLTWH(0, 100, 100, 100)),
  ];
  final List<bool> showChickens = [true, false, false];
  final List<Egg> fallingEggs = [];

  late final Ticker _ticker;
  @override
  void initState() {
    super.initState();
    _ticker = createTicker((dur) => onTick(dur));
    _ticker.start();
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
              top: player.rect.top,
              width: player.rect.width,
              left: player.rect.left,
              child: Image.asset("assets/images/eggbox.png"),
            ),
            for (var i = 0; i < 3; i++)
              if (showChickens[i])
                Positioned(
                  top: 150,
                  width: chickens[i].rect.width,
                  left: chickens[i].rect.left,
                  child: Image.asset("assets/images/chicken.gif"),
                ),
          ],
        ),
      ),
    );
  }

  void onTick(Duration dur) {
    for (var i = 0; i < 3; i++) {
      final Chicken chicken = chickens[i];
      if (dur.inSeconds > chicken.spawnDelay.inSeconds) {
        showChickens[i] = true;
        chickens[i] = Chicken(
          spawnDelay: 0.seconds,
          rect: chicken.rect,
          showChicken: true,
        );

        if (chicken.rect.left > Get.width - 50) {
          chickens[i] = Chicken(
            spawnDelay: 0.seconds,
            rect: chicken.rect.shift(Offset(-5, 0)),
          );
        }
        if (chicken.rect.right < 50) {
          chickens[i] = Chicken(
            spawnDelay: 0.seconds,
            rect: chicken.rect.shift(Offset(5, 0)),
          );
        }

        chickens[i] = Chicken(
          spawnDelay: 0.seconds,
          rect: chicken.rect,
          showChicken: true,
        );
      }
    }
    setState(() {});
  }
}
