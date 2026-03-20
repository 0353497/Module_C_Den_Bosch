import 'dart:math';

import 'package:cluck_catch/pages/game_page.dart';
import 'package:cluck_catch/pages/score_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Tween<double> rotatingRays = Tween(begin: 0, end: pi * 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Positioned.fill(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: Get.height * .5,
              child: Container(color: Color(0xff5EB5B9)),
            ),
            Positioned.fill(
              child: RepeatingAnimationBuilder(
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: value,
                    child: Transform.scale(
                      scale: 3,
                      child: Image.asset("assets/images/sun.png"),
                    ),
                  );
                },
                animatable: rotatingRays,
                duration: 5.seconds,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: Get.height * .5,
              bottom: 0,
              child: Container(color: Color(0xff6E8C39)),
            ),
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(0, 100),
                child: Transform.scale(
                  scale: 1.5,
                  child: Image.asset("assets/images/grass.png"),
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo_cluck_and_catch.png",
                    width: Get.width * .3,
                  ),
                  Image.asset(
                    "assets/images/chicken_coop.png",
                    width: Get.width * .3,
                  ),
                  SizedBox(
                    height: 60,
                    width: Get.width * .3,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color(0xffF47E23),
                        ),
                        foregroundColor: WidgetStatePropertyAll(
                          Color(0xffffffff),
                        ),
                      ),
                      onPressed: () => Get.to(() => GamePage()),
                      child: Text("START"),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: Get.width * .3,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(
                          Color(0xffffffff),
                        ),
                      ),
                      onPressed: () => Get.to(() => ScorePage()),
                      child: Text("SCORES"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
