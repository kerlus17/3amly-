// import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
// import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_states.dart';
// import 'package:elwaqar/Customers/Customer_widgets/States_Widgets.dart';
// import 'package:elwaqar/Customers/Customer_widgets/transaction_card.dart';
// import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
// import 'package:elwaqar/Customers/model/transaction/transaction_model.dart';
// import 'package:elwaqar/style/color_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AllTransaction extends StatelessWidget {
//   const AllTransaction({super.key, required this.customer});
//   final CustumerModel customer;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReadCustomerCubit, ReadCustomerState>(
//       builder: (context, state) {
//         if (state is ReadCustomerSuccessState) {
//           if (state.customers.isEmpty) {
//             return const StatesWidgets(
//               icon: Icon(Icons.air_rounded),
//               txt: "There is no customers",
//             );
//           } else {
//             // البحث عن العميل الآمن بدلاً من المباشر بـ Index لمنع الكراش
//             final currentCustomer = state.customers.firstWhere(
//               (c) => c.indexAtDatabase == customer.indexAtDatabase,
//               orElse: () => customer,
//             );

//             final List<TransactionModel> trans =
//                 currentCustomer.transactionsHistory ?? [];

//             if (trans.isEmpty) {
//               return const StatesWidgets(
//                 icon: Icon(Icons.receipt_long_outlined),
//                 txt: "There are no transactions for this customer",
//               );
//             }

//             return Expanded(child: _getCardTransaction(trans));
//           }
//         } else if (state is ReadCustomerErrorState) {
//           return StatesWidgets(
//             icon: const Icon(Icons.air_rounded),
//             txt: state.errorMessage,
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(color: ColorManager.white),
//           );
//         }
//       },
//     );
//   }

//   Widget _getCardTransaction(List<TransactionModel> trans) {
//     return ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       shrinkWrap: true, // يضمن عدم ضرب الشاشة في حال وجودها داخل Column
//       itemCount: trans.length,
//       itemBuilder: (context, index) {
//         final item = trans[index];
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 8.0),
//           child: TransactionCard(
//             customer: ,
//             title: item.nameOrder,
//             date: item.date.toString().split(' ')[0], // لعرض التاريخ بأسلوب أنيق
//             totalPrice: item.cost,
//             paid: item.payed,
//             remaining: item.rest,
//           ),
//         );
//       },
//     );
//   }
// }