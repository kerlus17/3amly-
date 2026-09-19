import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: ColorManager.primary800,
            borderRadius: BorderRadius.circular(10),
          ), // BoxDecoration
          child: Center(
            child: Text(
              "Done",
              style: TextStyle(
                color: ColorManager.white,
                fontWeight: FontWeight.w700,
              ),
            ), // Text
          ), // Center
        ),
      ),
    ); // Container
  }
}
