import 'package:elwaqar/Customers/Customer_widgets/stat_card.dart';
import 'package:elwaqar/core/widgets/page_header.dart';
import 'package:elwaqar/material/material_controller/material_read_cubit/Read_material_states.dart';
import 'package:elwaqar/material/material_controller/material_read_cubit/read_material_cubit.dart';
import 'package:elwaqar/material/material_widgets.dart/add_Material_dialog.dart';
import 'package:elwaqar/material/material_widgets.dart/all_Materials.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllMaterialsScreen extends StatelessWidget {
  const AllMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryLight,
      body: Column(
        children: [
          const PageHeader(title: 'المخزون', icon: Icons.storefront_outlined),
          Expanded(
            child: BlocBuilder<ReadMaterialCubit, ReadMaterialStates>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [_addMaterialButton(context)],
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            StatCard(
                              label: "اجمالي المخزون ",
                              value:
                                  (ReadMaterialCubit.get(context).getHighMaterials() +
                                          ReadMaterialCubit.get(context).getLowMaterials())
                                      .toString(),
                              background: ColorManager.primary400,
                              labelColor: ColorManager.primary800,
                              valueColor: ColorManager.primary900,
                            ),
                            SizedBox(width: 8),
                            StatCard(
                              label: "المخزون القليل",
                              value: ReadMaterialCubit.get(context)
                                  .getLowMaterials()
                                  .toString(),
                              background: ColorManager.errorRed.withOpacity(
                                0.12,
                              ),
                              labelColor: ColorManager.errorRed,
                              valueColor: ColorManager.errorRed,
                            ),
                            SizedBox(width: 8),
                            StatCard(
                              label: "المخزون المتوفر",
                              value: ReadMaterialCubit.get(context)
                                  .getHighMaterials()
                                  .toString(),

                              background: ColorManager.primary600.withOpacity(
                                0.15,
                              ),
                              labelColor: ColorManager.primary900,
                              valueColor: ColorManager.primary900,
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // إلتفاف الـ Widget بـ Expanded يحل المشكلة
                      const Expanded(child: AllMaterials()),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _addMaterialButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddMaterialDialog(),
          );
        },
        icon: const Icon(Icons.add, size: 16, color: ColorManager.white),
        label: const Text(
          'Add material',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: ColorManager.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          minimumSize: const Size(0, 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
