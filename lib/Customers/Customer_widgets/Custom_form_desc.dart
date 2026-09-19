import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customer_cubit.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';

class CustomFormDesc extends StatefulWidget {
  const CustomFormDesc({super.key, required this.formKey, required this.label});

  final GlobalKey<FormState> formKey;
  final String label;

  @override
  State<CustomFormDesc> createState() => _CustomformState();
}

class _CustomformState extends State<CustomFormDesc> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        autofocus: true,
        minLines: 1,
        maxLines: 5,
        controller: controller,
        cursorColor: ColorManager.black,

        style: TextStyle(color: ColorManager.white),
        decoration: _getinputdecoration(),
        onChanged: (value) => WriteCustomerCubit.get(context).updateDesc(value),

        validator: (value) {
          return _validator(value);
        },
      ),
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a word';
    }
    return null;
  }

  InputDecoration _getinputdecoration() {
    return InputDecoration(
      filled: true, // <-- هامة جداً عشان اللون يظهر!
      fillColor: ColorManager.black,
      labelText: widget.label,
      labelStyle: TextStyle(color: ColorManager.white),
      border: const OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
