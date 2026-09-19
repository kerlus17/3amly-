import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customers_states.dart';
import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
import 'package:elwaqar/core/constants/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwaqar/style/color_manager.dart';

class DeleteDialogTransaction extends StatefulWidget {
  final CustumerModel customer;
  final int indexofTransaction;

  const DeleteDialogTransaction ({super.key, required this.customer, required this.indexofTransaction});

  @override
  State<DeleteDialogTransaction> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<DeleteDialogTransaction> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteCustomerCubit, WriteCustomerState>(
      listener: (context, state) {
        if (state is WriteCustomerErrorState) {
          setState(() => _isDeleting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage.isNotEmpty
                    ? state.errorMessage
                    : "فشل حذف الاوردر",
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: ColorManager.errorRed,
            ),
          );
        } else if (state is WriteCustomerSuccessState) {
          ReadCustomerCubit.get(context).getCustomers();
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Dialog(
          backgroundColor: ColorManager.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            width: 380,
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
            decoration: BoxDecoration(
              color: ColorManager.primary900,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorManager.primary700, width: 0.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.exclamationmark_triangle,
                  color: ColorManager.errorRed,
                  size: 30,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "ازاله (${widget.customer.name})",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Custombutton(
                      icon: _isDeleting
                          ? CupertinoIcons.hourglass
                          : CupertinoIcons.trash,
                      txt: "متاكد",
                      onPressed: _isDeleting
                          ? () {}
                          : () {
                              setState(() => _isDeleting = true);
                              WriteCustomerCubit.get(
                                context,
                              ).deleteTransactionFromCustomer(widget.customer.indexAtDatabase,widget.indexofTransaction);
                            },
                    ),
                    SizedBox(width: 15),
                    Custombutton(
                      icon: CupertinoIcons.xmark,
                      txt: "تراجع",
                      onPressed: _isDeleting
                          ? () {}
                          : () {
                              Navigator.pop(context);
                            },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
