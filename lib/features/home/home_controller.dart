import 'package:get/get.dart';

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

class HomeController extends GetxController {
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
      income: 4000.00,
      expenses: 1200.00,
    ),
    WalletCardData(
      headerLabel: 'Business',
      totalBalance: 8320.50,
      income: 2100.00,
      expenses: 890.00,
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
