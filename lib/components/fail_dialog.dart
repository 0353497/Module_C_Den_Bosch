import 'package:cluck_catch/models/score.dart';
import 'package:cluck_catch/pages/homepage.dart';
import 'package:cluck_catch/provider/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FailDialog extends StatefulWidget {
  const FailDialog({super.key, required this.eggs, required this.onTap});
  final int eggs;
  final VoidCallback onTap;

  @override
  State<FailDialog> createState() => _FailDialogState();
}

class _FailDialogState extends State<FailDialog> {
  final TextEditingController _nameController = TextEditingController();
  final ScoreProvider provider = Get.find<ScoreProvider>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .5,
      height: Get.height * .6,
      child: Dialog(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "GAME OVER",
                style: TextStyle(
                  color: Color(0xffFF4D4D),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "WITH YOUR X!",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  if (provider.scores.isNotEmpty)
                    Row(
                      children: [
                        const Text("1"),
                        Text(provider.scores.first.name),

                        Text(provider.scores.first.name),
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(hint: Text("YOUR NAME")),
                          controller: _nameController,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color(0xffF47E23),
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            Color(0xffffffff),
                          ),
                        ),
                        onPressed: () {
                          provider.scores.add(
                            Score(
                              name: _nameController.value.text.trim(),
                              eggs: widget.eggs,
                              dateTime: DateTime.now(),
                            ),
                          );
                        },
                        child: Text("SAVE"),
                      ),
                    ],
                  ),
                  if (provider.scores.isNotEmpty)
                    Row(
                      children: [
                        const Text("3"),

                        Text(provider.scores.last.name),
                        Text(provider.scores.last.name),
                      ],
                    ),
                ],
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xffF47E23)),
                  foregroundColor: WidgetStatePropertyAll(Color(0xffffffff)),
                ),
                onPressed: widget.onTap,
                child: Text("PLAY AGAIN"),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                onPressed: () => Get.to(() => Homepage()),
                child: Text("BACK TO START"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
