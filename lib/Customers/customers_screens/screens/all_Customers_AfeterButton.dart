import 'package:elwaqar/Customers/Customer_widgets/all_customers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AllCustomersAfeterbutton extends StatelessWidget {
  const AllCustomersAfeterbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: AllCustomers())
        ],
      ),
    );
  }
}