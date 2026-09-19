import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customer_cubit.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';

class FormRestOfCustomer extends StatefulWidget {
  const FormRestOfCustomer({
    super.key,
    required this.formKey,
    required this.label,
  });

  final GlobalKey<FormState> formKey;
  final String label;

  @override
  State<FormRestOfCustomer> createState() => _CustomformState();
}

class _CustomformState extends State<FormRestOfCustomer> {
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
        cursorColor: ColorManager.white,

        style: TextStyle(color: ColorManager.white),
        decoration: _getinputdecoration(),
        onChanged: (value) {
          final doubleValue = double.tryParse(value) ?? 0.0;
          WriteCustomerCubit.get(context).updateRest(doubleValue);
        },
      ),
    );
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
