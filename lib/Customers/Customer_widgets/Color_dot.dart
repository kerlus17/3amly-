import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';

class ColorDot extends StatelessWidget {
  final int color;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorDot({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: Color(color),
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: ColorManager.black, width: 4)
              : null,
        ),
      ),
    );
  }
}