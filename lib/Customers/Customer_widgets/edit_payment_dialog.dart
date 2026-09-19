import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customers_states.dart';
import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
import 'package:elwaqar/Customers/model/payment/payment_model.dart';
import 'package:elwaqar/core/constants/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwaqar/style/color_manager.dart';

class EditPaymentDialog extends StatefulWidget {
  final CustumerModel customer;
  final PaymentModel oldpayment;
  final int indexOfPayment;

  const EditPaymentDialog({
    super.key,
    required this.customer,
    required this.oldpayment, required this.indexOfPayment,
  });

  @override
  State<EditPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<EditPaymentDialog> {
  final _dateCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  double get _amount => double.tryParse(_amountCtrl.text) ?? 0;

  @override
  void initState() {
    super.initState();

    _dateCtrl.text = widget.oldpayment.date.toString();
    _amountCtrl.text = widget.oldpayment.amount.toString();
    final now = DateTime.now();
    _dateCtrl.text =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _dateCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteCustomerCubit, WriteCustomerState>(
      listener: (context, state) {
        if (state is WriteCustomerErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage.isNotEmpty
                    ? state.errorMessage
                    : "Failed to edit transaction",
              ),
              backgroundColor: ColorManager.red,
            ),
          );
        } else if (state is WriteCustomerSuccessState) {
          ReadCustomerCubit.get(context).getCustomers();
          Navigator.of(context).pop();
          ReadCustomerCubit.get(context).getCustomers();
        }
      },

      builder: (context, state) {
        return Dialog(
          backgroundColor: ColorManager.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.primary900,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorManager.primary700, width: 0.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [_buildHeader(), _buildBody(), _buildFooter()],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: ColorManager.primaryDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(
          bottom: BorderSide(color: ColorManager.primary700, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: ColorManager.primary600,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.payments_outlined,
              color: ColorManager.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add payment',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.white,
                ),
              ),
              Text(
                '${widget.customer.name}',
                style: const TextStyle(
                  fontSize: 11,
                  color: ColorManager.primary400,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: ColorManager.primary800,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: ColorManager.primary600, width: 0.5),
              ),
              child: const Icon(
                Icons.close,
                color: ColorManager.primary400,
                size: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date
          _label('Date'),
          const SizedBox(height: 5),
          _input(_dateCtrl, hint: 'YYYY-MM-DD'),
          const SizedBox(height: 14),

          // Amount
          _label('Amount paid'),
          const SizedBox(height: 5),
          _input(_amountCtrl, hint: '0', keyboardType: TextInputType.number),
          const SizedBox(height: 16),

          // Preview
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorManager.primaryDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorManager.primary700, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Preview',
                  style: TextStyle(
                    fontSize: 11,
                    color: ColorManager.primary400,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: ColorManager.primary400,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          _dateCtrl.text.isEmpty ? '—' : _dateCtrl.text,
                          style: const TextStyle(
                            fontSize: 13,
                            color: ColorManager.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _amount > 0 ? '+${_amount.toStringAsFixed(0)} ج' : '— ج',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.primary600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: const BoxDecoration(
        color: ColorManager.primaryDark,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        border: Border(
          top: BorderSide(color: ColorManager.primary700, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Custombutton(
            txt: "cancel",
            icon: CupertinoIcons.return_icon,
            onPressed: () => Navigator.pop(context),
            background: ColorManager.primaryDark,
            colortxtAndIcon: ColorManager.splashCream,
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.check, size: 13, color: ColorManager.white),
            label: const Text(
              'Save',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: ColorManager.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary600,
              elevation: 0,
              minimumSize: const Size(0, 32),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: ColorManager.primary400,
      letterSpacing: 0.03,
    ),
  );

  Widget _input(
    TextEditingController ctrl, {
    String hint = '',
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      textDirection: TextDirection.ltr,
      onChanged: (_) => setState(() {}),
      style: const TextStyle(fontSize: 13, color: ColorManager.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 13,
          color: ColorManager.primary500,
        ),
        filled: true,
        fillColor: ColorManager.primaryDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ColorManager.primary600,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ColorManager.primary600,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ColorManager.primary600,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  void _save() {
    if (_dateCtrl.text.trim().isEmpty || _amount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('من فضلك املأ كل الحقول'),
          backgroundColor: ColorManager.errorRed,
        ),
      );
      return;
    }

    DateTime date = DateTime.parse(_dateCtrl.text);

    WriteCustomerCubit.get(context).editPaymentCustomer(
      widget.customer.indexAtDatabase,
      widget.indexOfPayment,
      _amount,
      date,
      widget.oldpayment.amount,
    );
  }
}
