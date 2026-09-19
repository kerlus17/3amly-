import 'package:elwaqar/Customers/Customer_widgets/delete_dialog_transaction.dart';
import 'package:elwaqar/Customers/Customer_widgets/edit_transaction_dialog.dart';
import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
import 'package:elwaqar/Customers/model/transaction/transaction_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:elwaqar/style/color_manager.dart';

class TransactionCard extends StatelessWidget {
  final String date;
  final String status;
  final Color accentColor;
  final CustumerModel customer;
  final int indexOftransaction;

  final TransactionModel transaction;

  const TransactionCard({
    super.key,
    required this.date,
    this.status = "Paid",

    this.accentColor = ColorManager.primary,
    required this.customer,
    required this.transaction,
    required this.indexOftransaction,
  });

  Color get _badgeBg => switch (status) {
    'Paid' => ColorManager.primary600.withOpacity(0.16),
    'Partial' => ColorManager.primary500.withOpacity(0.20),
    _ => ColorManager.errorRed.withOpacity(0.12),
  };

  Color get _badgeFg => switch (status) {
    'Paid' => ColorManager.primary900,
    'Partial' => ColorManager.primary800,
    _ => ColorManager.errorRed,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      margin: EdgeInsets.only(bottom: 8),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.nameOrder,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.primaryDark,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 12,
                                color: ColorManager.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: ColorManager.primary,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _badgeBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _badgeFg,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: ColorManager.divider, height: 1),
                const SizedBox(height: 12),
                // Rows
                _Row(
                  label: 'Total price',
                  value: '${transaction.cost.toStringAsFixed(0)} ج',
                  valueColor: ColorManager.primary900,
                ),
                const SizedBox(height: 8),
                _Row(
                  label: 'Paid',
                  value: '+${transaction.payed.toStringAsFixed(0)} ج',
                  valueColor: ColorManager.primary600,
                ),
                const SizedBox(height: 8),
                _Row(
                  label: 'Remaining',
                  value: '${transaction.rest.toStringAsFixed(0)} ج',
                  valueColor: transaction.rest > 0
                      ? ColorManager.errorRed
                      : ColorManager.primary900,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteDialogTransaction(
                          customer: customer,
                          indexofTransaction: indexOftransaction,
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
                        return EditTransactionDialog(
                          indexOfTransaction:indexOftransaction ,
                          customer: customer,
                          oldTransaction: transaction,
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

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _Row({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, color: ColorManager.primary800),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
