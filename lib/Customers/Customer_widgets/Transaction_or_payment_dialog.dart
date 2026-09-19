import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:elwaqar/style/color_manager.dart';

class TransactionOrPaymentDialog extends StatefulWidget {
  const TransactionOrPaymentDialog({super.key});

  @override
  State<TransactionOrPaymentDialog> createState() =>
      TransactionOrPaymentDialogState();
}

class TransactionOrPaymentDialogState extends State<TransactionOrPaymentDialog>
    with SingleTickerProviderStateMixin {
  bool _isTransaction = ReadCustomerCubit().TransactionOrPayment==TransactionsORpayments.transactions? true :false;
  late AnimationController _ctrl;
  late Animation<double> _slideAnim;
  final List<_Bubble> _bubbles = [];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _slideAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
  }

  void _select(bool isTransaction) {
    if (_isTransaction == isTransaction) return;
    setState(() {
      _isTransaction = isTransaction;
      _spawnBubbles();
    });
    isTransaction ? _ctrl.reverse() : _ctrl.forward();
  }

  void _spawnBubbles() {
    final rng = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < 5; i++) {
      _bubbles.add(
        _Bubble(
          id: rng + i,
          x: (i * 22.0) % 120,
          y: (i * 11.0) % 40,
          size: 8 + (i * 5.0) % 14,
        ),
      );
    }
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _bubbles.clear());
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const tabW = 130.0;
    const tabH = 48.0;
    const gap = 10.0;

    return Dialog(
      backgroundColor: ColorManager.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.primary900,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorManager.primary700, width: 0.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ──────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
              decoration: const BoxDecoration(
                color: ColorManager.primaryDark,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                    child: const Icon(Icons.add, color: ColorManager.white, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add new',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.white,
                        ),
                      ),
                      Text(
                        'Choose the type below',
                        style: TextStyle(
                          fontSize: 11,
                          color: ColorManager.primary400,
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
                        border: Border.all(
                          color: ColorManager.primary600,
                          width: 0.5,
                        ),
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
            ),

            // ── Selector ────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ColorManager.primaryDark,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: ColorManager.primary700,
                        width: 0.5,
                      ),
                    ),
                    child: SizedBox(
                      height: tabH,
                      width: (tabW * 2) + gap,
                      child: Stack(
                        children: [
                          // Animated pill
                          AnimatedBuilder(
                            animation: _slideAnim,
                            builder: (_, __) => Positioned(
                              left: _slideAnim.value * (tabW + gap),
                              top: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: tabW,
                                  height: tabH,
                                  child: Stack(
                                    children: [
                                      Container(color: ColorManager.primary),
                                      ..._bubbles.map(
                                        (b) => _BubbleWidget(bubble: b),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Transaction
                          Positioned(
                            left: 0,
                            top: 0,
                            width: tabW,
                            height: tabH,
                            child: InkWell(
                              onTap:  () {
                                _select(true);
                                ReadCustomerCubit.get(
                                  context,
                                ).updateTransactionOrPayment(
                                  TransactionsORpayments.transactions,
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.receipt_long_outlined,
                                      size: 15,
                                      color: _isTransaction
                                          ? ColorManager.white
                                          : ColorManager.primary400,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Transaction',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: _isTransaction
                                            ? ColorManager.white
                                            : ColorManager.primary400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Payment
                          Positioned(
                            left: tabW + gap,
                            top: 0,
                            width: tabW,
                            height: tabH,
                            child: InkWell(
                              onTap: () {
                                _select(false);
                                ReadCustomerCubit.get(
                                  context,
                                ).updateTransactionOrPayment(
                                  TransactionsORpayments.payments,
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.payments_outlined,
                                      size: 15,
                                      color: !_isTransaction
                                          ? ColorManager.white
                                          : ColorManager.primary400,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Payment',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: !_isTransaction
                                            ? ColorManager.white
                                            : ColorManager.primary400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Footer ──────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
              decoration: const BoxDecoration(
                color: ColorManager.primaryDark,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(color: ColorManager.primary700, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorManager.primary400,
                      side: const BorderSide(
                        color: ColorManager.primary600,
                        width: 0.5,
                      ),
                      minimumSize: const Size(0, 34),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancel', style: TextStyle(fontSize: 13)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        _isTransaction ? 'transaction' : 'payment',
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: ColorManager.white,
                    ),
                    label: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      elevation: 0,
                      minimumSize: const Size(0, 34),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Bubble classes ───────────────────────────────────────────────────────────

class _Bubble {
  final int id;
  final double x, y, size;
  const _Bubble({
    required this.id,
    required this.x,
    required this.y,
    required this.size,
  });
}

class _BubbleWidget extends StatefulWidget {
  final _Bubble bubble;
  const _BubbleWidget({required this.bubble});

  @override
  State<_BubbleWidget> createState() => _BubbleWidgetState();
}

class _BubbleWidgetState extends State<_BubbleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    )..forward();
    _scale = Tween(
      begin: 0.0,
      end: 3.5,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _opacity = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Positioned(
        left: widget.bubble.x,
        top: widget.bubble.y,
        child: Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            scale: _scale.value,
            child: Container(
              width: widget.bubble.size,
              height: widget.bubble.size,
              decoration: BoxDecoration(
                color: ColorManager.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
