import 'package:cluck_catch/pages/homepage.dart';
import 'package:cluck_catch/provider/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
  Get.put<ScoreProvider>(ScoreProvider());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: "Freeman"),
      title: 'Cluck & Catch',
      home: Homepage(),
    );
  }
}
