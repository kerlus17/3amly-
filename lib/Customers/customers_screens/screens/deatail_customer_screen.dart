import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_states.dart';
import 'package:elwaqar/Customers/Customer_widgets/States_Widgets.dart';
import 'package:elwaqar/Customers/Customer_widgets/payment_Card.dart';
import 'package:elwaqar/Customers/Customer_widgets/payment_dialog.dart';

import 'package:elwaqar/Customers/Customer_widgets/transaction_card.dart';
import 'package:elwaqar/Customers/Customer_widgets/transaction_dialog.dart';
import 'package:elwaqar/Customers/Customer_widgets/transaction_or_payment_button.dart';
import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeatailCustomerScreen extends StatefulWidget {
  const DeatailCustomerScreen({super.key, required this.customer});

  final CustumerModel customer;

  @override
  State<DeatailCustomerScreen> createState() => _DeatailCustomerScreenState();
}

class _DeatailCustomerScreenState extends State<DeatailCustomerScreen> {
  late CustumerModel _Cust;

  @override
  void initState() {
    _Cust = widget.customer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryLight,
      appBar: _getaAppbar(
        context,
        widget.customer.name.substring(0, 1),
        widget.customer,
      ),
      body: BlocBuilder<ReadCustomerCubit, ReadCustomerState>(
        builder: (context, state) {
          if (state is ReadCustomerSuccessState) {
            int index = state.customers.indexWhere(
              (Element) => Element.indexAtDatabase == _Cust.indexAtDatabase,
            );
            _Cust = state.customers[index];
            if (ReadCustomerCubit.get(context).TransactionOrPayment ==
                TransactionsORpayments.transactions) {
              return _getbodyOfTransaction();
            }
            if (ReadCustomerCubit.get(context).TransactionOrPayment ==
                TransactionsORpayments.payments) {
              return _getbodyOfPayments();
            }
          }
          if (state is ReadCustomerErrorState) {
            return StatesWidgets(
              icon: Icon(Icons.error),
              txt: state.toString(),
            );
          }
          return StatesWidgets(icon: Icon(Icons.circle_sharp), txt: "loading");
        },
      ),
    );
  }

  Padding _getbodyOfTransaction() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          _getRowofPaymentOrTransaction(),
          SizedBox(height: 10),
          _getRowOfTransaction(),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _Cust.transactionsHistory.length, // الرقم بيتحط هنا
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              // الفانكشن بتتحط هنا
              final item = _Cust.transactionsHistory[index];
              return TransactionCard(
                customer: _Cust,
                date: item.date.toString(),
                transaction: item,
                indexOftransaction: index,
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _getbodyOfPayments() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ReadCustomerCubit, ReadCustomerState>(
        builder: (context, state) {
          if (state is ReadCustomerSuccessState) {
            return ListView(
              children: [
                _getRowofPaymentOrTransaction(),
                SizedBox(height: 10),
                _getRowOfPayment(),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _Cust.paymentsHistory.length, // الرقم بيتحط هنا
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    // الفانكشن بتتحط هنا
                    final item = _Cust.paymentsHistory[index];
                    return PaymentCard(
                      indexOfPayment: index,
                      customer: _Cust,
                      payment: item,
                    );
                  },
                ),
              ],
            );
          } else if (state is ReadCustomerErrorState) {
            return StatesWidgets(
              icon: Icon(Icons.air_rounded),
              txt: state.errorMessage,
            );
          } else {
            return CircularProgressIndicator(color: ColorManager.white);
          }
        },
      ),
    );
  }

  Row _getRowOfTransaction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TRANSACTIONS',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: ColorManager.primary700,
            letterSpacing: 0.8,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddTransactionDialog(
                  customer: widget.customer,
                );
              },
            );
          },
          icon: const Icon(Icons.add, size: 13, color: ColorManager.white),
          label: const Text(
            'Add',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ColorManager.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            minimumSize: const Size(0, 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Row _getRowOfPayment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Payments',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: ColorManager.primary700,
            letterSpacing: 0.8,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddPaymentDialog(
                  customerName: widget.customer.name,
                  customer: widget.customer,
                );
              },
            );
          },
          icon: const Icon(Icons.add, size: 13, color: ColorManager.white),
          label: const Text(
            'Add',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ColorManager.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            minimumSize: const Size(0, 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Row _getRowofPaymentOrTransaction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [TransactionOrPaymentButton()],
    );
  }

  AppBar _getaAppbar(
    BuildContext context,
    String initials,
    CustumerModel currentCustomer,
  ) {
    return AppBar(
      backgroundColor: ColorManager.surfaceStrong,
      elevation: 0,
      shadowColor: ColorManager.transparent,
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
            decoration: BoxDecoration(
              color: ColorManager.primary400,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.arrow_forward,
              color: ColorManager.primary800,
              size: 15,
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: Color(currentCustomer.color),
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: ColorManager.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentCustomer.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.primary900,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: const [
        _ActionBtn(icon: Icons.edit_outlined),
        _ActionBtn(icon: Icons.phone_outlined),
        _ActionBtn(icon: Icons.more_horiz),
        SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary900.withOpacity(0.10),
                blurRadius: 14,
                spreadRadius: -2,
                offset: const Offset(0, 6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  const _ActionBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.symmetric(vertical: 11, horizontal: 4),
        decoration: BoxDecoration(
          color: ColorManager.primary400,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: ColorManager.primary800, size: 15),
      ),
    );
  }
}
