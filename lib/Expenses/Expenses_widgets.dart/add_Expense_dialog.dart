import 'package:elwaqar/core/constants/customButton.dart';
import 'package:elwaqar/Customers/Customer_widgets/text_field_dialog_transaction.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_read_cubit/read_expenses_cubit.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_write_cubit/write_expenses_cubit.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_write_cubit/write_expenses_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwaqar/style/color_manager.dart';

class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({super.key});

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final _nameCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateCtrl.text =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteExpensesCubit, WriteExpensesStates>(
      listener: (context, state) {
        if (state is WriteExpensesErrorStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.msg.isNotEmpty ? state.msg : "Failed to add expense",
              ),
              backgroundColor: ColorManager.red,
            ),
          );
        } else if (state is WriteExpensesSuccessStates) {
          ReadExpensesCubit.get(context).getExpenses();
          Navigator.of(context).pop();
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Expense',
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
          // Name
          _label('Expense name'),
          const SizedBox(height: 5),
          TextFieldDialogTransaction(
            ctrl: _nameCtrl,
            onChanged: (value) {
              setState(() {
                WriteExpensesCubit.get(context).updateName(value);
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
                    _label('Price'),
                    const SizedBox(height: 5),
                    TextFieldDialogTransaction(
                      ctrl: _priceCtrl,
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
                  label: 'Name',
                  value: _nameCtrl.text.trim().isEmpty
                      ? "—"
                      : _nameCtrl.text.trim(),
                  valueColor: ColorManager.white,
                ),
                const SizedBox(height: 6),
                _PreviewRow(
                  label: 'Date',
                  value: _dateCtrl.text.trim().isEmpty
                      ? "—"
                      : _dateCtrl.text.trim(),
                  valueColor: ColorManager.primary400,
                ),
                const SizedBox(height: 6),
                _PreviewRow(
                  label: 'Price',
                  value:
                      '${double.tryParse(_priceCtrl.text)?.toStringAsFixed(0) ?? "—"} ج',
                  valueColor: ColorManager.primary600,
                ),
                const SizedBox(height: 6),
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
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorManager.primary400,
              side: const BorderSide(
                color: ColorManager.primary600,
                width: 0.5,
              ),
              minimumSize: const Size(0, 32),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Cancel', style: TextStyle(fontSize: 12)),
          ),
          Custombutton(
            txt: "save",
            icon: Icons.check,
            onPressed: () {
              double price = double.tryParse(_priceCtrl.text) ?? 0.0;
              DateTime date =
                  DateTime.tryParse(_dateCtrl.text.trim()) ?? DateTime.now();
              WriteExpensesCubit.get(
                context,
              ).addExpense(_nameCtrl.text.trim(), date, price);
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
