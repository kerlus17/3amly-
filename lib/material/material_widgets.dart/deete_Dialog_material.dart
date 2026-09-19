import 'package:elwaqar/core/constants/customButton.dart';

import 'package:elwaqar/material/material_controller/material_read_cubit/read_material_cubit.dart';
import 'package:elwaqar/material/material_controller/material_write_cubit/write_material_cubit.dart';
import 'package:elwaqar/material/material_controller/material_write_cubit/write_material_states.dart';
import 'package:elwaqar/material/material_model/material_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwaqar/style/color_manager.dart';

class DeeteDialogMaterial extends StatefulWidget {
  final MaterialModel material;

  const DeeteDialogMaterial({super.key, required this.material});

  @override
  State<DeeteDialogMaterial> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<DeeteDialogMaterial> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteMaterialCubit, WriteMaterialStates>(
      listener: (context, state) {
        if (state is WriteMaterialErrorStates) {
          setState(() => _isDeleting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.msg.isNotEmpty ? state.msg : "فشل حذف الصنف",
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: ColorManager.errorRed,
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
                        "ازاله (${widget.material.name})",
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
                              WriteMaterialCubit.get(context)
                                  .deleteMaterial(
                                      widget.material.indexAtDatabase);
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