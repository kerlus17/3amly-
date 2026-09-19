import 'dart:ui';

import 'package:elwaqar/Customers/Customer_widgets/delete_Dialog_customer.dart';
import 'package:elwaqar/Customers/customers_screens/screens/deatail_customer_screen.dart';
import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final CustumerModel customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final initials = customer.name
        .trim()
        .split(' ')
        .take(2)
        .map((w) => w[0])
        .join();

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DeatailCustomerScreen(customer: customer);
            },
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.splashBrownDark,
          borderRadius: BorderRadius.circular(14),
          border: Border(
            left: BorderSide(color: Color(customer.color), width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary900.withOpacity(0.22),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(customer.color),
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primary900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      customer.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorManager.primary500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    customer.remainingAmount.toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: customer.debtOrNo
                          ? ColorManager.errorRed
                          : ColorManager.primary400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      customer.debtOrNo ? "depted" : "Done",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: customer.debtOrNo
                            ? ColorManager.primary400
                            : ColorManager.primary900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteDialogCustomer(customer: customer,);
                    },
                  );
                },
                child: Icon(
                  CupertinoIcons.delete_solid,
                  color: ColorManager.primary500,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
