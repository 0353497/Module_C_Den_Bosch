import 'package:cluck_catch/models/score.dart';
import 'package:cluck_catch/provider/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  final ScoreProvider provider = Get.find<ScoreProvider>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6E8C39),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -.6),
            child: Image.asset("assets/images/grass.png"),
          ),
          Align(
            alignment: Alignment(0, -.6),
            child: Text(
              "SCORES",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: Get.height * .6,
              width: Get.width * .3,
              child: ListView.builder(
                itemCount: provider.scores.length,
                itemBuilder: (BuildContext context, int index) {
                  List<Score> scores = provider.scores;
                  scores.sort((a, b) => a.eggs.compareTo(b.eggs));
                  final Score score = scores[index];
                  return Row(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 24,
                        children: [
                          Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            score.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${score.eggs} EGGS",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
