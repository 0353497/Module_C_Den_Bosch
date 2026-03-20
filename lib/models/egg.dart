import 'package:flutter/material.dart';

class Egg {
  final Rect rect;
  final bool isRotten;

  Egg({required this.rect, required this.isRotten});
  Egg copyWith({Rect? rect, bool? isRotten}) {
    return Egg(rect: rect ?? this.rect, isRotten: isRotten ?? this.isRotten);
  }
}
