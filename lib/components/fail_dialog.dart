import 'package:cluck_catch/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FailDialog extends StatelessWidget {
  const FailDialog({super.key, required this.eggs, required this.onTap});
  final int eggs;
  final VoidCallback onTap;
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
              Row(children: [TextFormField()]),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xffF47E23)),
                  foregroundColor: WidgetStatePropertyAll(Color(0xffffffff)),
                ),
                onPressed: onTap,
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
