import 'package:elwaqar/Customers/Customer_widgets/Transaction_or_payment_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elwaqar/style/color_manager.dart';

class TransactionOrPaymentButton extends StatefulWidget {

  const TransactionOrPaymentButton({super.key,});

  @override
  State<TransactionOrPaymentButton> createState() => _AnimatedFabButtonState();
}

class _AnimatedFabButtonState extends State<TransactionOrPaymentButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _glow = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (_, child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withOpacity(0.25 + (_glow.value * 0.35)),
              blurRadius: 12 + (_glow.value * 16),
              spreadRadius: _glow.value * 3,
            ),
          ],
        ),
        child: child,
      ),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return TransactionOrPaymentDialog();
            },
          );
        },
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            color: ColorManager.primary900,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: ColorManager.primary.withOpacity(0.6),
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: ColorManager.primary800,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorManager.primary.withOpacity(0.4),
                    width: 0.5,
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.add,
                  color: ColorManager.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Add transaction / payment',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
