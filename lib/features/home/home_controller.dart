import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../utils/constcolors.dart';

/// One scrollable wallet / balance card on the home screen.
class WalletCardData {
  const WalletCardData({
    required this.headerLabel,
    required this.accountType,
    required this.totalBalance,
  });

  final String headerLabel;
  /// e.g. Cash, Bank, Debit — shown as small caption under the title.
  final String accountType;
  final double totalBalance;
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

/// One transaction row preview for the home screen.
/// Expense uses [ConstColor.Thirdcolor] and income uses [ConstColor.Fourthcolor].
class HomeTransactionPreview {
  const HomeTransactionPreview({
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

    // Wallet tab -> Accounts screen (index mapping comes from
    // AppBottomNavBar.defaultDestinations order).
    if (index == 2) {
      Get.toNamed(AppRoutes.accounts);
      return;
    }

    // TODO: Add navigation for Statistics / Profile when those screens exist.
  }

  /// Placeholder until profile is loaded from auth/storage.
  static const String userName = 'Hamza Rashid';

  /// Home summary row (Income / Expense cards under balance carousel).
  static const double homeSummaryIncome = 18548.99;
  static const double homeSummaryExpense = 1445.93;

  /// Multiple balances — horizontal carousel.
  final List<WalletCardData> balanceCards = const [
    WalletCardData(
      headerLabel: 'Total Balance',
      accountType: 'Cash',
      totalBalance: 2548.00,
    ),
    WalletCardData(
      headerLabel: 'Savings',
      accountType: 'Bank',
      totalBalance: 12000.00,
    ),
    WalletCardData(
      headerLabel: 'Business',
      accountType: 'Debit',
      totalBalance: 8320.50,
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

  /// Transactions list shown after Categories section.
  final List<HomeTransactionPreview> homeTransactionsPreview = [
    HomeTransactionPreview(
      title: 'Groceries',
      amount: HomeController.formatUsd(58.90),
      icon: Icons.shopping_bag_outlined,
      backgroundColor: ConstColor.Thirdcolor,
    ),
    HomeTransactionPreview(
      title: 'Fuel Expense',
      amount: HomeController.formatUsd(36.40),
      icon: Icons.local_gas_station_outlined,
      backgroundColor: ConstColor.Thirdcolor,
    ),
    HomeTransactionPreview(
      title: 'Salary Income',
      amount: HomeController.formatUsd(1200.00),
      icon: Icons.payments_outlined,
      backgroundColor: ConstColor.Fourthcolor,
    ),
    HomeTransactionPreview(
      title: 'Freelance Income',
      amount: HomeController.formatUsd(620.00),
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
