import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Components/app_bottom_nav_bar.dart';
import '../../Components/category_card.dart';
import '../../Components/transaction_cell.dart';
import '../../app/routes/app_routes.dart';
import '../../utils/constcolors.dart';
import 'home_controller.dart';

abstract final class _HomeUi {
  /// Large top radius so the white sheet reads like the reference (slides up from bottom).
  static const sheetTopRadius = 40.0;
  static const badge = Color(0xFFFF8C42);

  /// Income / Expense summary cards.
  static const summaryCardRadius = 28.0;
  static const summaryCardHeight = 132.0;

}

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const _horizontalPad = 20.0;
  static const _cardRadius = 20.0;
  /// Height for one balance card (title + account type + total + rings).
  static const _balanceCarouselHeight = 150.0;
  static const _cardCarouselGap = 14.0;
  /// Card width as fraction of screen so the next card peeks (horizontal slider).
  static const _cardWidthFraction = 0.78;
  static const _categoryGridSpacing = 12.0;
  static const _categoryCardAspect = 1.50;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final screenW = MediaQuery.sizeOf(context).width;
    final cardWidth = screenW * _cardWidthFraction;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: ConstColor.Thirdcolor,
        bottomNavigationBar: Obx(
          () => AppBottomNavBar(
            currentIndex: controller.bottomNavIndex.value,
            onTap: controller.selectBottomNav,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                _horizontalPad,
                topInset + 8,
                _horizontalPad,
                20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            height: 1.05,
                            color: ConstColor.Primarycolor,
                          ),
                        ),
                        Text(
                          'morning,',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                            height: 1.05,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          HomeController.userName,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            color: ConstColor.Primarycolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: ConstColor.Primarycolor,
                      foregroundColor: ConstColor.Secondaycolor,
                      padding: const EdgeInsets.all(10),
                      minimumSize: const Size(48, 48),
                      maximumSize: const Size(48, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          size: 24,
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: _HomeUi.badge,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ConstColor.Secondaycolor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(_HomeUi.sheetTopRadius),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ConstColor.Primarycolor.withValues(alpha: 0.06),
                      blurRadius: 28,
                      offset: const Offset(0, -6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(_HomeUi.sheetTopRadius),
                  ),
                  child: SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            _horizontalPad,
                            35,
                            _horizontalPad,
                            0,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => Get.toNamed(AppRoutes.accounts),
                            child: const Text(
                              'Accounts',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: ConstColor.Primarycolor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: _balanceCarouselHeight,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                              left: _horizontalPad,
                              right: _horizontalPad * 0.35,
                            ),
                            itemCount: controller.balanceCards.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: _cardCarouselGap),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: cardWidth,
                                child: _BalanceCard(
                                  data: controller.balanceCards[index],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            _horizontalPad,
                            18,
                            _horizontalPad,
                            0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    child: _IncomeExpenseSummaryCard(
                                      label: 'Income',
                                      amount: HomeController.formatUsd(
                                        HomeController.homeSummaryIncome,
                                      ),
                                      backgroundColor: ConstColor.Fourthcolor,
                                      leadingIcon:
                                          Icons.arrow_upward_rounded,
                                      leadingIconColor: ConstColor.Secondaycolor,
                                      watermarkIcon:
                                          Icons.arrow_upward_rounded,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _IncomeExpenseSummaryCard(
                                      label: 'Expense',
                                      amount: HomeController.formatUsd(
                                        HomeController.homeSummaryExpense,
                                      ),
                                      backgroundColor: ConstColor.Thirdcolor,
                                      leadingIcon: Icons.arrow_downward_rounded,
                                      leadingIconColor: ConstColor.Secondaycolor,
                                      watermarkIcon:
                                          Icons.arrow_downward_rounded,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            _horizontalPad,
                            22,
                            _horizontalPad,
                            0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Categories',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: ConstColor.Primarycolor,
                                    ),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 2),
                                      child: Text(
                                        'View all',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: ConstColor.Primarycolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: _categoryGridSpacing,
                                  crossAxisSpacing: _categoryGridSpacing,
                                  childAspectRatio: _categoryCardAspect,
                                ),
                                itemCount: controller.homeCategoryPreview.length,
                                itemBuilder: (context, index) {
                                  final c =
                                      controller.homeCategoryPreview[index];
                                  return CategoryCard(
                                    title: c.title,
                                    amount: c.amount,
                                    icon: c.icon,
                                    backgroundColor: c.backgroundColor,
                                  );
                                },
                              ),
                              const SizedBox(height: 14),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Transactions',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: ConstColor.Primarycolor,
                                    ),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 2),
                                      child: Text(
                                        'View all',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: ConstColor.Primarycolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    controller.homeTransactionsPreview.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final t = controller.homeTransactionsPreview[index];
                                  return TransactionCell(
                                    title: t.title,
                                    amount: t.amount,
                                    icon: t.icon,
                                    backgroundColor: t.backgroundColor,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IncomeExpenseSummaryCard extends StatelessWidget {
  const _IncomeExpenseSummaryCard({
    required this.label,
    required this.amount,
    required this.backgroundColor,
    required this.leadingIcon,
    required this.leadingIconColor,
    required this.watermarkIcon,
  });

  final String label;
  final String amount;
  final Color backgroundColor;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final IconData watermarkIcon;

  // static const _onCard = Colors.white;
  static const _onCard = ConstColor.Primarycolor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _HomeUi.summaryCardHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_HomeUi.summaryCardRadius),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned.fill(
              child: ColoredBox(color: backgroundColor),
            ),
            Positioned(
              right: -36,
              top: -28,
              child: IgnorePointer(
                child: Container(
                  width: 118,
                  height: 118,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _onCard.withValues(alpha: 0.07),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -8,
              top: 28,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.11,
                  child: Icon(
                    watermarkIcon,
                    size: 102,
                    color: _onCard,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 14, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: _onCard,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      leadingIcon,
                      size: 20,
                      color: leadingIconColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: _onCard.withValues(alpha: 0.72),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    amount,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      height: 1.05,
                      letterSpacing: -0.4,
                      color: _onCard,
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

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.data});

  final WalletCardData data;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(HomeScreen._cardRadius),
      color: ConstColor.Thirdcolor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HomeScreen._cardRadius),
          border: Border.all(
            color: ConstColor.Primarycolor.withValues(alpha: 0.08),
          ),
        ),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(HomeScreen._cardRadius),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            const Positioned.fill(
              child: ColoredBox(color: ConstColor.Thirdcolor),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: _BalanceCardRingPainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    data.headerLabel,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: ConstColor.Primarycolor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.accountType,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: ConstColor.Primarycolor.withValues(alpha: 0.55),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    HomeController.formatUsd(data.totalBalance),
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: ConstColor.Primarycolor,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

/// Concentric rings from a single center **left of the card** — only the right-hand
/// arcs show inside the clip, so they read as one smooth sweep from left → mid.
class _BalanceCardRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Shared focal point (off-canvas left): all circles are concentric → clean ripple.
    final center = Offset(-w * 0.36, h * 0.5);

    // Outermost first (painted under), inner last — or paint inner on top for clarity.
    // Radii chosen so each ring crosses further into the card (left edge → ~65% width).
    final rings = <({double radiusFactor, double strokeWidth, double opacity})>[
      (radiusFactor: 0.98, strokeWidth: 1.0, opacity: 0.085),
      (radiusFactor: 0.78, strokeWidth: 1.1, opacity: 0.105),
      (radiusFactor: 0.58, strokeWidth: 1.2, opacity: 0.13),
    ];

    for (final r in rings) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r.strokeWidth
        ..color = ConstColor.Primarycolor.withValues(alpha: r.opacity);

      canvas.drawCircle(
        center,
        w * r.radiusFactor,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BalanceCardRingPainter oldDelegate) => false;
}
