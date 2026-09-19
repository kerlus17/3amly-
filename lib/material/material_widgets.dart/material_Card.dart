import 'package:elwaqar/material/material_model/material_model.dart';
import 'package:elwaqar/material/material_widgets.dart/deete_Dialog_material.dart';
import 'package:elwaqar/material/material_widgets.dart/edit_material_dialog.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  final MaterialModel material;

  const MaterialCard({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    final initials = material.name
        .trim()
        .split(' ')
        .take(2)
        .map((w) => w[0])
        .join();

    final isLow = material.amount < material.alertAmount;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.primary900,
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: ColorManager.primary400, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary900.withOpacity(0.22),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: ColorManager.primary500,
                  child: Text(
                    initials,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primary900,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    material.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      material.amount.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isLow
                            ? ColorManager.errorRed
                            : ColorManager.primary400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isLow ? "محدود" : "متوفر",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: isLow
                              ? ColorManager.primary400
                              : ColorManager.primary900,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buttonEditOrDelete(context, () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeeteDialogMaterial(material: material);
                    },
                  );
                }, CupertinoIcons.delete_solid),

                SizedBox(width: 20),

                _buttonEditOrDelete(context, () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return EditMaterialDialog(oldMaterial: material);
                    },
                  );
                }, CupertinoIcons.pencil),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buttonEditOrDelete(
  BuildContext context,
  VoidCallback fun,
  IconData icondata,
) {
  return Expanded(
    child: InkWell(
      onTap: fun,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: ColorManager.primary400),
        ),
        child: Icon(icondata, color: ColorManager.primary400, size: 25),
      ),
    ),
  );
}
