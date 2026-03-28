import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/constcolors.dart';
import 'home_controller.dart';

/// Teal dashboard palette (reference UI).
abstract final class _HomeColors {
  static const header = Color(0xFF2A9D90);
  static const card = Color(0xFF267A70);
  static const notificationSurface = Color(0x40FFFFFF);
  static const badge = Color(0xFFFF8C42);
  static const labelMuted = Color(0xCCFFFFFF);
}

class _TealPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withValues(alpha: 0.07);
    canvas.drawCircle(Offset(size.width * 0.88, size.height * 0.05), 72, p);
    canvas.drawCircle(Offset(size.width * -0.05, size.height * 0.55), 100, p);
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.15), 48, p);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.65), 56, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const _headerBottomRadius = 32.0;
  static const _horizontalPad = 20.0;
  static const _cardRadius = 24.0;
  /// Vertical space for greeting + name (two lines + spacing).
  static const _greetingBlockHeight = 48.0;
  static const _gapBelowName = 48.0;
  /// Half of approximate card height — card straddles teal / white at this depth.
  static const _cardHalfOverlap = 108.0;
  /// Fixed height for horizontal balance list (card content + shadow).
  static const _balanceCarouselHeight = 248.0;
  static const _cardCarouselGap = 14.0;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final tealSectionHeight = topInset +
        5 +
        _greetingBlockHeight +
        _gapBelowName +
        _cardHalfOverlap;
    final screenW = MediaQuery.sizeOf(context).width;
    final cardWidth = screenW - (_horizontalPad * 2);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: ConstColor.Secondaycolor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: tealSectionHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(_headerBottomRadius),
                        bottomRight: Radius.circular(_headerBottomRadius),
                      ),
                      child: ColoredBox(
                        color: _HomeColors.header,
                        child: CustomPaint(
                          painter: _TealPatternPainter(),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: topInset + 4,
                    left: _horizontalPad,
                    right: _horizontalPad,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.timeGreeting,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                HomeController.userName,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: _HomeColors.notificationSurface,
                            foregroundColor: Colors.white,
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
                                    color: _HomeColors.badge,
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
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -_cardHalfOverlap),
              child: SizedBox(
                height: _balanceCarouselHeight,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: _horizontalPad),
                  physics: const BouncingScrollPhysics(),
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
            ),
            const Expanded(
              child: ColoredBox(
                color: ConstColor.Secondaycolor,
                child: SizedBox.expand(),
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
      elevation: 10,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(HomeScreen._cardRadius),
      color: _HomeColors.card,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 26, 16, 20),
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
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 22,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_rounded),
                  color: Colors.white,
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
                color: Colors.white,
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
                  color: Colors.white.withValues(alpha: 0.2),
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
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: _HomeColors.labelMuted,
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
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
