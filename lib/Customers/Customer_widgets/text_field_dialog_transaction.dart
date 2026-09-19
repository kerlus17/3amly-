import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:elwaqar/style/color_manager.dart';

class TextFieldDialogTransaction extends StatelessWidget {
  const TextFieldDialogTransaction({super.key, required this.ctrl, this.onChanged,  this.hint=""});
 final TextEditingController ctrl; 
    final String hint ;
    final TextInputType keyboardType = TextInputType.text;
    final  ValueChanged<String>? onChanged;



  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 13, color: ColorManager.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: ColorManager.primary500),
        filled: true,
        fillColor: ColorManager.primaryDark,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ColorManager.primary600, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ColorManager.primary600, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ColorManager.primary, width: 1.5),
        ),
      ),
    );
  }
}