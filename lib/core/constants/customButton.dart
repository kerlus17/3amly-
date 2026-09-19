import 'package:flutter/material.dart';
import 'package:elwaqar/style/color_manager.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    super.key,
    required this.txt,
    required this.icon,
    this.onPressed,  this.colortxtAndIcon=ColorManager.white,  this.background=ColorManager.primary,
  });

  final String txt;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color colortxtAndIcon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: ElevatedButton.icon(
        onPressed: onPressed ?? () {},
        icon: Icon(icon, size: 18, color: colortxtAndIcon),
        label: Text(
          txt,
          style:  TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colortxtAndIcon,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          minimumSize: const Size(0, 42),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
