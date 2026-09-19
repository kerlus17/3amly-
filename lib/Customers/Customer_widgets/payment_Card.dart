import 'package:elwaqar/Customers/Customer_widgets/delete_Payment_dialog.dart';
import 'package:elwaqar/Customers/Customer_widgets/edit_payment_dialog.dart';
import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
import 'package:elwaqar/Customers/model/payment/payment_model.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final Color accentColor;
  final CustumerModel customer;
  final PaymentModel payment;
  final int indexOfPayment;

  const PaymentCard({
    super.key,
    this.accentColor = ColorManager.primary600,
    required this.customer,
    required this.payment,
    required this.indexOfPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorManager.hairline, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary900.withOpacity(0.20),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Accent top bar
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeletePaymentDialog(
                              customer: customer,
                              indexofPayments: indexOfPayment,
                            );
                          },
                        );
                      },
                      child: Icon(
                        CupertinoIcons.delete_solid,
                        color: ColorManager.red,
                        size: 25,
                      ),
                    ),
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: ColorManager.primary700,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      payment.date.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.primary900,
                      ),
                    ),
                  ],
                ),
                // Amount
                Text(
                  '+${payment.amount.toStringAsFixed(0)} ج',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primary600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeletePaymentDialog(
                          customer: customer,
                          indexofPayments: indexOfPayment,
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 10),

                    decoration: BoxDecoration(
                      color: ColorManager.primary500,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: ColorManager.hairline,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.delete_solid,
                        color: ColorManager.red,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return EditPaymentDialog(
                          indexOfPayment:indexOfPayment ,
                          customer: customer,
                          oldpayment: payment,
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: ColorManager.primary500,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: ColorManager.hairline,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.pencil,
                        color: ColorManager.red,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }
}
