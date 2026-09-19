import 'package:elwaqar/core/constants/customButton.dart';
import 'package:elwaqar/Customers/Customer_widgets/text_field_dialog_transaction.dart';
import 'package:elwaqar/material/material_controller/material_read_cubit/read_material_cubit.dart';
import 'package:elwaqar/material/material_controller/material_write_cubit/write_material_cubit.dart';
import 'package:elwaqar/material/material_controller/material_write_cubit/write_material_states.dart';
import 'package:elwaqar/material/material_model/material_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwaqar/style/color_manager.dart';

class EditMaterialDialog extends StatefulWidget {
  const EditMaterialDialog({super.key, required this.oldMaterial});
  final MaterialModel oldMaterial;

  @override
  State<EditMaterialDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<EditMaterialDialog> {
  final _titleCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _AmountCtrl = TextEditingController();
  final _AmountAlertCtrl = TextEditingController();

  double get _safe {
    final t = double.tryParse(_AmountCtrl.text) ?? 0;
    final p = double.tryParse(_AmountAlertCtrl.text) ?? 0;
    return (t - p).clamp(0, double.infinity);
  }

  @override
  void initState() {
    super.initState();

    _titleCtrl.text = widget.oldMaterial.name;
    _AmountCtrl.text = widget.oldMaterial.amount.toString();
    _AmountAlertCtrl.text = widget.oldMaterial.alertAmount.toString();

    final now = DateTime.now();
    _dateCtrl.text =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteMaterialCubit, WriteMaterialStates>(
      listener: (context, state) {
        if (state is WriteMaterialErrorStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.msg.isNotEmpty ? state.msg : "Failed to add transaction",
              ),
              backgroundColor: ColorManager.red,
            ),
          );
        } else if (state is WriteMaterialSuccessStates) {
          ReadMaterialCubit.get(context).getMaterials();
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Material',
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
          _label('Material name'),
          const SizedBox(height: 5),
          TextFieldDialogTransaction(
            ctrl: _titleCtrl,
            onChanged: (value) {
              setState(() {
                WriteMaterialCubit.get(context).updateName(value);
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
                    _label('Total Amount'),
                    const SizedBox(height: 5),
                    TextFieldDialogTransaction(
                      ctrl: _AmountCtrl,
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
                    _label('Amount Alert'),
                    const SizedBox(height: 5),
                    TextFieldDialogTransaction(
                      ctrl: _AmountAlertCtrl,
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
                    _label('Safe'),
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
                        _safe > 0
                            ? '${_safe.toStringAsFixed(0)} قطعه'
                            : ' تخطيت مرحله الامان',
                        style: TextStyle(
                          fontSize: 13,
                          color: _safe > 0
                              ? ColorManager.primary500
                              : ColorManager.errorRed,
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
                  label: 'Total Amount',
                  value:
                      '${double.tryParse(_AmountCtrl.text)?.toStringAsFixed(0) ?? "—"} ',
                  valueColor: ColorManager.white,
                ),
                const SizedBox(height: 6),
                _PreviewRow(
                  label: 'AlertAmount',
                  value:
                      '+${double.tryParse(_AmountAlertCtrl.text)?.toStringAsFixed(0) ?? "—"} ',
                  valueColor: ColorManager.primary600,
                ),
                const SizedBox(height: 6),
                _PreviewRow(
                  label: 'Safe',
                  value: '${_safe.toStringAsFixed(0)} ج',
                  valueColor: _safe > 0
                      ? ColorManager.primary500
                      : ColorManager.errorRed,
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
        
           Custombutton(
            txt: "cancel",
            icon: CupertinoIcons.return_icon,
           onPressed: () => Navigator.pop(context),
           background: ColorManager.primary900 ,
           colortxtAndIcon: ColorManager.surface,
          ),
          Custombutton(
            txt: "save",
            icon: Icons.check,
            onPressed: () {
              double amount = double.tryParse(_AmountCtrl.text) ?? 0.0;
              double amountalert =
                  double.tryParse(_AmountAlertCtrl.text) ?? 0.0;
              WriteMaterialCubit.get(
                context,
              ).editMaterial(widget.oldMaterial.indexAtDatabase,amountalert,_titleCtrl.text,amount);
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
