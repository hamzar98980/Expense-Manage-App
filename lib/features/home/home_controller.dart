import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constcolors.dart';

/// One scrollable wallet / balance card on the home screen.
class WalletCardData {
  const WalletCardData({
    required this.headerLabel,
    required this.totalBalance,
    required this.income,
    required this.expenses,
  });

  final String headerLabel;
  final double totalBalance;
  final double income;
  final double expenses;
}

/// Home “Categories” grid row — expense uses [ConstColor.Thirdcolor], income [ConstColor.Fourthcolor].
class HomeCategoryPreview {
  const HomeCategoryPreview({
    required this.title,
    required this.amount,
    required this.icon,
    required this.backgroundColor,
  });

  final String title;
  final String amount;
  final IconData icon;
  final Color backgroundColor;
}

class HomeController extends GetxController {
  /// Bottom bar selection (reuse pattern on other tab roots).
  final RxInt bottomNavIndex = 0.obs;

  void selectBottomNav(int index) {
    if (index == bottomNavIndex.value) return;
    bottomNavIndex.value = index;
    // Wire navigation when Statistics / Wallet / Profile screens exist.
  }

  /// Placeholder until profile is loaded from auth/storage.
  static const String userName = 'Hamza Rashid';

  /// Multiple balances — horizontal carousel.
  final List<WalletCardData> balanceCards = const [
    WalletCardData(
      headerLabel: 'Total Balance',
      totalBalance: 2548.00,
      income: 1840.00,
      expenses: 284.00,
    ),
    WalletCardData(
      headerLabel: 'Savings',
      totalBalance: 12000.00,
      income: 400.00,
      expenses: 210.00,
    ),
    WalletCardData(
      headerLabel: 'Business',
      totalBalance: 8320.50,
      income: 2100.00,
      expenses: 890.00,
    ),
  ];

  /// First four categories on the home sheet (2×2). Expense → Thirdcolor, income → Fourthcolor.
  final List<HomeCategoryPreview> homeCategoryPreview = [
    HomeCategoryPreview(
      title: 'Grocery Expense',
      amount: HomeController.formatUsd(290.50),
      icon: Icons.shopping_bag_outlined,
      backgroundColor: ConstColor.Thirdcolor,
    ),
    HomeCategoryPreview(
      title: 'Fuel Expense',
      amount: HomeController.formatUsd(290.50),
      icon: Icons.local_gas_station_outlined,
      backgroundColor: ConstColor.Thirdcolor,
    ),
    HomeCategoryPreview(
      title: 'Salary Income',
      amount: HomeController.formatUsd(290.50),
      icon: Icons.payments_outlined,
      backgroundColor: ConstColor.Fourthcolor,
    ),
    HomeCategoryPreview(
      title: 'Freelance Income',
      amount: HomeController.formatUsd(290.50),
      icon: Icons.laptop_mac_outlined,
      backgroundColor: ConstColor.Fourthcolor,
    ),
  ];

  /// Static for now; switch to time-based when needed.
  String get timeGreeting => 'Good morning,';

  static String formatUsd(double amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final dec = parts[1];
    final chars = intPart.split('');
    final out = <String>[];
    for (var i = 0; i < chars.length; i++) {
      final fromEnd = chars.length - i;
      if (i > 0 && fromEnd % 3 == 0) {
        out.add(',');
      }
      out.add(chars[i]);
    }
    return '\$ ${out.join()}.$dec';
  }
}
