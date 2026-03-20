import 'package:flutter/material.dart';

class Egg {
  final Rect rect;
  final bool isRotten;
  final bool isFaster;
  Egg({required this.rect, required this.isRotten, required this.isFaster});
  Egg copyWith({Rect? rect, bool? isRotten, bool? isFaster}) {
    return Egg(
      rect: rect ?? this.rect,
      isRotten: isRotten ?? this.isRotten,
      isFaster: isFaster ?? this.isFaster,
    );
  }
}
