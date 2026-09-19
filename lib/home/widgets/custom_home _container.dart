import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomHomeContainer extends StatelessWidget {
  const CustomHomeContainer({
    super.key,
    required this.Label,
    required this.Num,
    required this.LabelTwo,
    required this.FunnyIcon, required this.color,
  });

  final String Label;
  final String Num;
  final String LabelTwo;
  final String FunnyIcon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,

      decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(FunnyIcon),
              Text(Label, style: TextStyle(fontWeight: FontWeight.w800)),
              Spacer(),
              Text(LabelTwo),
              Icon(CupertinoIcons.graph_square),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                Num,
                style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              9, // عدد الشرطات
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 25,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
