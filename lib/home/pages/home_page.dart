import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_states.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_read_cubit/read_expenses_cubit.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_read_cubit/Read_expenses_states.dart';
import 'package:elwaqar/home/widgets/custom_home%20_container.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCustomerCubit, ReadCustomerState>(
      builder: (context, customerState) {
        return BlocBuilder<ReadExpensesCubit, ReadExpensesStates>(
          builder: (context, expensesState) {
            final readCustomerCubit = context.read<ReadCustomerCubit>();
            final readExpensesCubit = context.read<ReadExpensesCubit>();

            return Scaffold(
              backgroundColor: ColorManager.primary900,
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Hello, Manager",
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "Let us check how our busniness feel today !",
                      style: TextStyle(
                        color: ColorManager.red,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 50),

                    CustomHomeContainer(
                      color: Color.fromRGBO(215, 244, 52, 1),
                      FunnyIcon: "💰",
                      LabelTwo: "10 % upper ",
                      Label: "اجمالي مبيعات السنه",
                      Num: readCustomerCubit.TotalpurchasesUntillNow()
                          .toString(),
                    ),
                    SizedBox(height: 15),

                    CustomHomeContainer(
                      color: Color.fromRGBO(150, 173, 227, 1),
                      FunnyIcon: "💵",
                      LabelTwo: "50 % upper ",
                      Label: "ارباح السنه بالمتبقي لدي العملاء",
                      Num:
                          (readCustomerCubit.TotalWinsWithRemains() -
                                  readExpensesCubit.totalExpenses)
                              .toString(),
                    ),
                    SizedBox(height: 15),
                    CustomHomeContainer(
                      color: Color.fromRGBO(152, 48, 82, 1),
                      FunnyIcon: "💵",
                      LabelTwo: "50 % upper ",
                      Label: "المتبقي لدي العملاء",
                      Num: readCustomerCubit.totalOutRemining().toString(),
                    ),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
