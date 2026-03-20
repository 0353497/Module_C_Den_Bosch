import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
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
                itemBuilder: (BuildContext context, int index) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
