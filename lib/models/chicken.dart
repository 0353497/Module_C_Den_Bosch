import 'package:flutter/material.dart';

class Chicken {
  final Duration spawnDelay;
  final Rect rect;
  final bool showChicken;
  final Duration lastSpawnEgg;
  final bool goesToLeft;
  final int randomDelay;

  Chicken({
    required this.spawnDelay,
    required this.rect,
    this.showChicken = false,
    this.lastSpawnEgg = Duration.zero,
    this.goesToLeft = false,
    this.randomDelay = 0,
  });

  Chicken copyWith({
    Duration? spawnDelay,
    Rect? rect,
    bool? showChicken,
    Duration? lastSpawnEgg,
    bool? goesToLeft,
    int? randomDelay,
  }) {
    return Chicken(
      spawnDelay: spawnDelay ?? this.spawnDelay,
      rect: rect ?? this.rect,
      showChicken: showChicken ?? this.showChicken,
      lastSpawnEgg: lastSpawnEgg ?? this.lastSpawnEgg,
      goesToLeft: goesToLeft ?? this.goesToLeft,
      randomDelay: randomDelay ?? this.randomDelay,
    );
  }
}
