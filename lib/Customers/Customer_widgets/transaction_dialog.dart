import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customers_states.dart';
import 'package:elwaqar/core/constants/customButton.dart';
import 'package:elwaqar/Customers/Customer_widgets/text_field_dialog_transaction.dart';
import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwaqar/style/color_manager.dart';

class AddTransactionDialog extends StatefulWidget {

  final CustumerModel customer;

  const AddTransactionDialog({
    super.key,

    required this.customer,
  });

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _titleCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _totalCtrl = TextEditingController();
  final _paidCtrl = TextEditingController();

  String _status = 'Paid';
  double get _remaining {
    final t = double.tryParse(_totalCtrl.text) ?? 0;
    final p = double.tryParse(_paidCtrl.text) ?? 0;
    return (t - p).clamp(0, double.infinity);
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateCtrl.text =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
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
                    : "Failed to add transaction",
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
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            width: 420,
            decoration: BoxDecoration(
              color: ColorManager.primary900,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorManager.primary700, width: 0.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                _buildBody(),
                _buildFooter(widget.customer.indexAtDatabase),
              ],
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
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              color: ColorManager.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add transaction',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.white,
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
          // Title
          _label('Transaction name'),
          const SizedBox(height: 5),
          TextFieldDialogTransaction(
            ctrl: _titleCtrl,
            onChanged: (value) {
              setState(() {
                WriteCustomerCubit.get(context).updateName(value);
              });
            },
          ),
          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Date'),
                    const SizedBox(height: 5),
                    TextFieldDialogTransaction(
                      ctrl: _dateCtrl,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Total price'),
                    const SizedBox(height: 5),
                    TextFieldDialogTransaction(
                      ctrl: _totalCtrl,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Paid + Remaining
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Amount paid'),
                    const SizedBox(height: 5),
                    TextFieldDialogTransaction(
                      ctrl: _paidCtrl,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Remaining'),
                    const SizedBox(height: 5),
                    Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: ColorManager.primaryDark,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: ColorManager.primary600,
                          width: 0.5,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _remaining > 0
                            ? '${_remaining.toStringAsFixed(0)} ج'
                            : '0 ج',
                        style: TextStyle(
                          fontSize: 13,
                          color: _remaining > 0
                              ? ColorManager.errorRed
                              : ColorManager.primary500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Status

          // Divider
          const Divider(color: ColorManager.primary700, height: 1),

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
                _PreviewRow(
                  label: 'Total price',
                  value:
                      '${double.tryParse(_totalCtrl.text)?.toStringAsFixed(0) ?? "—"} ج',
                  valueColor: ColorManager.white,
                ),
                const SizedBox(height: 6),
                _PreviewRow(
                  label: 'Paid',
                  value:
                      '+${double.tryParse(_paidCtrl.text)?.toStringAsFixed(0) ?? "—"} ج',
                  valueColor: ColorManager.primary600,
                ),
                const SizedBox(height: 6),
                _PreviewRow(
                  label: 'Remaining',
                  value: '${_remaining.toStringAsFixed(0)} ج',
                  valueColor: _remaining > 0
                      ? ColorManager.errorRed
                      : ColorManager.primary500,
                ),
                const SizedBox(height: 6),
                _PreviewRow(
                  label: 'Status',
                  value: _status,
                  valueColor: _status == 'Paid'
                      ? ColorManager.primary600
                      : _status == 'Partial'
                      ? ColorManager.primary500
                      : ColorManager.errorRed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(String custindex) {
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
        children: [
          const Icon(
            Icons.info_outline,
            size: 13,
            color: ColorManager.primary500,
          ),
          const SizedBox(width: 4),
          const Text(
            'All fields are required',
            style: TextStyle(fontSize: 11, color: ColorManager.primary500),
          ),
          const Spacer(),

          Custombutton(
            txt: "cancel",
            icon: CupertinoIcons.return_icon,
            onPressed: () => Navigator.pop(context),
               background: ColorManager.primaryDark,
            colortxtAndIcon: ColorManager.splashCream,
          ),

          Custombutton(
            txt: "save",
            icon: Icons.check,
            onPressed: () {
              String nameOrder = _titleCtrl.text;
              double costOfOrder = double.tryParse(_totalCtrl.text) ?? 0.0;
              double payedOfOrder = double.tryParse(_paidCtrl.text) ?? 0.0;
              double restOfOrder = _remaining;

              WriteCustomerCubit.get(context).addTransactionToCustomer(
                widget.customer.indexAtDatabase,
                nameOrder,
                costOfOrder,
                payedOfOrder,
                restOfOrder,
              );
            },
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
}

class _PreviewRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _PreviewRow({
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
          style: const TextStyle(fontSize: 12, color: ColorManager.primary400),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
