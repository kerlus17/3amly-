
import 'package:elwaqar/Customers/Customer_widgets/States_Widgets.dart';
import 'package:elwaqar/material/material_controller/material_read_cubit/Read_material_states.dart';
import 'package:elwaqar/material/material_controller/material_read_cubit/read_material_cubit.dart';
import 'package:elwaqar/material/material_model/material_model.dart';
import 'package:elwaqar/material/material_widgets.dart/material_Card.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllMaterials extends StatelessWidget {
  const AllMaterials({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadMaterialCubit, ReadMaterialStates>(
      builder: (context, state) {
        if (state is ReadMaterialSuccessStates) {
          if (state.materials.isEmpty) {
            return StatesWidgets(
              icon: Icon(Icons.air_rounded),
              txt: "there is no materials",
            );
          } else {
            return _getCardMaterial(state.materials);
          }
        } else if (state is ReadMaterialErrorStates) {
          return StatesWidgets(
            icon: Icon(Icons.air_rounded),
            txt: state.msg,
          );
        } else {
          return CircularProgressIndicator(color: ColorManager.white);
        }
      },
    );
  }

  Widget _getCardMaterial(List<MaterialModel> materials) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return MaterialCard(material: materials[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: materials.length,
    );
  }
}
