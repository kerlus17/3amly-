import 'package:flutter/widgets.dart';

class StatesWidgets extends StatelessWidget {
  const StatesWidgets({super.key, required this.txt, required this.icon});
  final String txt;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [Text(txt),
    icon]));
  }
}
