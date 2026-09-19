import 'package:elwaqar/Customers/customers_screens/screens/All_customers_screen.dart';
import 'package:elwaqar/Expenses/Expenses_screens/All_expenses_screen.dart';
import 'package:elwaqar/home/pages/home_page.dart';
import 'package:elwaqar/material/material_screens/All_materials_screen.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Root dashboard that lets the user switch between the Customers,
/// Inventory (Materials) and Expenses sections via a bottom navigation bar.
/// Each section keeps its own Scaffold/AppBar and its own state
/// (IndexedStack keeps all three alive, so switching tabs doesn't reset them).
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    AllCustomersScreen(),
    AllMaterialsScreen(),
    AllExpensesScreen(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedIndex ==0? ColorManager.primary900:ColorManager.primaryLight,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: ColorManager.primaryLight.withOpacity(0.5),
                blurRadius: 26,
                spreadRadius: -4,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               _NavItem(
                icon: CupertinoIcons.money_pound,
                label: 'الرئيسيه',
                selected: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
              ),
              _NavItem(
                icon: CupertinoIcons.group_solid,
                label: 'العملاء',
                selected: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
              ),
              _NavItem(
                icon: CupertinoIcons.shopping_cart,
                label: 'المخزون',
                selected: _selectedIndex == 2,
                onTap: () => setState(() => _selectedIndex = 2),
              ),
              _NavItem(
                icon: CupertinoIcons.money_pound,
                label: 'المصروفات',
                selected: _selectedIndex == 3,
                onTap: () => setState(() => _selectedIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: selected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ColorManager.black, ColorManager.errorRed],
                )
              : null,
          borderRadius: BorderRadius.circular(14),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: ColorManager.primary600.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: selected ? ColorManager.white : ColorManager.primary700,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? ColorManager.white : ColorManager.primary700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
