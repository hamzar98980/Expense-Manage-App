import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Components/app_bottom_nav_bar.dart';
import '../../Components/category_card.dart';
import '../../utils/constcolors.dart';
import 'home_controller.dart';

abstract final class _HomeUi {
  /// Large top radius so the white sheet reads like the reference (slides up from bottom).
  static const sheetTopRadius = 40.0;
  static const badge = Color(0xFFFF8C42);
}

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const _horizontalPad = 20.0;
  static const _cardRadius = 20.0;
  /// Height for one balance card (header → income/expenses).
  static const _balanceCarouselHeight = 230.0;
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
                            26,
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
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
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: ConstColor.Primarycolor.withValues(alpha: 0.85),
                    size: 22,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_rounded),
                    color: ConstColor.Primarycolor,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _StatColumn(
                      icon: Icons.arrow_downward_rounded,
                      label: 'Income',
                      amount: HomeController.formatUsd(data.income),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 44,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    color: ConstColor.Primarycolor.withValues(alpha: 0.12),
                  ),
                  Expanded(
                    child: _StatColumn(
                      icon: Icons.arrow_upward_rounded,
                      label: 'Expenses',
                      amount: HomeController.formatUsd(data.expenses),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.icon,
    required this.label,
    required this.amount,
  });

  final IconData icon;
  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: ConstColor.Primarycolor.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: ConstColor.Primarycolor, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: ConstColor.Primarycolor.withValues(alpha: 0.65),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ConstColor.Primarycolor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
