import 'package:cluck_catch/models/score.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ScoreProvider extends GetxController {
  final List<Score> scores = [];
  final highScore = 0.obs;
}
