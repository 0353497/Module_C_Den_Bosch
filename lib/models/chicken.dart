import 'package:flutter/material.dart';

class Chicken {
  final Duration spawnDelay;
  final Rect rect;
  final bool showChicken;

  Chicken({
    required this.spawnDelay,
    required this.rect,
    this.showChicken = false,
  });
}
