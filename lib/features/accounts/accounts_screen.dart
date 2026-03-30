import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../utils/constcolors.dart';
import 'accounts_controller.dart';

class AccountsScreen extends GetView<AccountsController> {
  const AccountsScreen({super.key});

  static const _cardRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.Secondaycolor,
      appBar: AppBar(
        backgroundColor: ConstColor.Secondaycolor,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          'Accounts',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            color: ConstColor.Primarycolor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.createAccount),
        backgroundColor: ConstColor.Fourthcolor,
        foregroundColor: ConstColor.Primarycolor,
        elevation: 2,
          shape: const CircleBorder(), // 👈 ensures perfect circle
        child: const Icon(Icons.add, size: 28),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 88),
          children: [
            for (var i = 0; i < controller.accounts.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              _AccountCard(
                account: controller.accounts[i],
                cardRadius: _cardRadius,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.account,
    required this.cardRadius,
  });

  final AccountPreview account;
  final double cardRadius;

  static const _cardHeight = 150.0;
  static const _pad = 20.0;
  static const _watermarkOpacity = 0.16;
  static const _watermarkSize = 128.0;
  static const _watermarkRotation = -0.42;

  Color _onAccent(Color bg) =>
      bg.computeLuminance() > 0.55 ? ConstColor.Primarycolor : Colors.white;

  @override
  Widget build(BuildContext context) {
    final bg = account.backgroundColor;
    final primary = _onAccent(bg);
    final secondary = primary.withValues(alpha: 0.82);

    return Material(
      color: bg,
      elevation: 2,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(cardRadius),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: _cardHeight,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: -26,
              right: -32,
              child: Transform.rotate(
                angle: _watermarkRotation,
                child: Opacity(
                  opacity: _watermarkOpacity,
                  child: Icon(
                    account.icon,
                    size: _watermarkSize,
                    color: primary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(_pad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                      color: primary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    account.type,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: secondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AccountsController.formatUsd(account.amount),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                      color: primary,
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

