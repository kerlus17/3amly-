import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_states.dart';
import 'package:elwaqar/Customers/Customer_widgets/States_Widgets.dart';
import 'package:elwaqar/Customers/Customer_widgets/customer_card.dart';
import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCustomers extends StatelessWidget {
  const AllCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCustomerCubit, ReadCustomerState>(
      builder: (context, state) {
        if (state is ReadCustomerSuccessState) {
          if (state.customers.isEmpty) {
            return StatesWidgets(
              icon: Icon(Icons.air_rounded),
              txt: "there is no customers",
            );
          } else {
            return _getCardCustomer(state.customers);
          }
        } else if (state is ReadCustomerErrorState) {
          return StatesWidgets(
            icon: Icon(Icons.air_rounded),
            txt: state.errorMessage,
          );
        } else {
          return CircularProgressIndicator(color: ColorManager.white);
        }
      },
    );
  }

  Widget _getCardCustomer(List<CustumerModel> customers) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return CustomerCard(customer: customers[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: customers.length,
    );
  }
}
