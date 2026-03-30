import 'package:expense_manager/Utils/constcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPreview {
  const AccountPreview({
    required this.name,
    required this.type,
    required this.amount,
    required this.backgroundColor,
    required this.icon,
  });

  final String name;
  final String type; // e.g. Cash / Debit
  final double amount;
  final Color backgroundColor;
  final IconData icon;
}

class AccountsController extends GetxController {
  /// List of accounts — solid accent per card (watermark icon uses same family as reference).
  final List<AccountPreview> accounts = [
    AccountPreview(
      name: 'Main Cash',
      type: 'Cash',
      amount: 520.50,
      backgroundColor: ConstColor.Fourthcolor,
      icon: Icons.payments_outlined,
    ),
    AccountPreview(
      name: 'Everyday Debit',
      type: 'Debit',
      amount: 1250.00,
      backgroundColor: ConstColor.Thirdcolor,
      icon: Icons.credit_card_outlined,
    ),
    AccountPreview(
      name: 'Savings Vault',
      type: 'Cash',
      amount: 8450.25,
      backgroundColor: ConstColor.Fourthcolor,
      icon: Icons.savings_outlined,
    ),
    AccountPreview(
      name: 'Business Account',
      type: 'Debit',
      amount: 3320.75,
      backgroundColor: ConstColor.Thirdcolor,
      icon: Icons.account_balance_outlined,
    ),
  ];

  static String formatUsd(double amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final dec = parts[1];
    final chars = intPart.split('');
    final out = <String>[];
    for (var i = 0; i < chars.length; i++) {
      final fromEnd = chars.length - i;
      if (i > 0 && fromEnd % 3 == 0) out.add(',');
      out.add(chars[i]);
    }
    return '\$ ${out.join()}.$dec';
  }
}

