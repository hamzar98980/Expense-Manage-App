import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Components/app_bottom_nav_bar.dart';
import '../../utils/constcolors.dart';
import '../home/home_controller.dart';
import 'stats_controller.dart';

abstract final class _StatsChartUi {
  static const tooltipBg = Color(0xFF1A1C24);
  /// Expense line / legend on [ConstColor.Thirdcolor] surfaces.
  static const expenseMuted = Color(0xFF78716C);
}

class StatsScreen extends GetView<StatsController> {
  const StatsScreen({super.key});

  static const _horizontalPad = 20.0;

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: ConstColor.Thirdcolor,
        bottomNavigationBar: Obx(
          () => AppBottomNavBar(
            currentIndex: home.bottomNavIndex.value,
            onTap: home.selectBottomNav,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              _horizontalPad,
              12,
              _horizontalPad,
              24,
            ),
            child: _StatsSummaryCard(
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}

/// [Thirdcolor] card on [Secondaycolor] screen; chart + metrics inside.
class _StatsSummaryCard extends StatelessWidget {
  const _StatsSummaryCard({required this.controller});

  final StatsController controller;

  static const _cardRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    final net = controller.netLastMonth;
    final netPct = controller.netChangePercent;
    final positive = netPct >= 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 5,
          top: 10,
          right: -4,
          bottom: -10,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(_cardRadius + 4),
            ),
          ),
        ),
        Material(
          color: ConstColor.Thirdcolor,
          elevation: 10,
          shadowColor: Colors.black.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(_cardRadius),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STATISTICS',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.35,
                        color: ConstColor.Primarycolor.withValues(alpha: 0.4),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.more_vert_rounded,
                      size: 22,
                      color: ConstColor.Primarycolor.withValues(alpha: 0.32),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _formatHeroNumber(net),
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                        letterSpacing: -1.4,
                        color: ConstColor.Primarycolor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${positive ? '+' : ''}${netPct.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: positive
                            ? ConstColor.Fourthcolor
                            : const Color(0xFFDC2626),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      positive
                          ? Icons.north_east_rounded
                          : Icons.south_east_rounded,
                      size: 18,
                      color: positive
                          ? ConstColor.Fourthcolor
                          : const Color(0xFFDC2626),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '6-month net',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ConstColor.Primarycolor.withValues(alpha: 0.45),
                  ),
                ),
                const SizedBox(height: 18),
                const _Legend(
                  incomeColor: ConstColor.Fourthcolor,
                  expenseColor: _StatsChartUi.expenseMuted,
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 220,
                  child: _IncomeExpenseLineChart(controller: controller),
                ),
                const SizedBox(height: 22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _FooterMetric(
                        value: controller.incomeMomPercent,
                        label: 'Income growth',
                        valueColor: ConstColor.Fourthcolor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _FooterMetric(
                        value: controller.expenseMomPercent,
                        label: 'Expense change',
                        valueColor: _StatsChartUi.expenseMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static String _formatHeroNumber(double v) {
    final n = v.round();
    final sign = n < 0 ? '-' : '';
    final s = n.abs().toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) {
        buf.write(',');
      }
      buf.write(s[i]);
    }
    return '$sign$buf';
  }
}

class _FooterMetric extends StatelessWidget {
  const _FooterMetric({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  final double value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final positive = value >= 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${positive ? '+' : ''}${value.toStringAsFixed(2)}%',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 17,
            fontWeight: FontWeight.w800,
            height: 1.1,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 11,
            fontWeight: FontWeight.w500,
            height: 1.25,
            color: ConstColor.Primarycolor.withValues(alpha: 0.44),
          ),
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({
    required this.incomeColor,
    required this.expenseColor,
  });

  final Color incomeColor;
  final Color expenseColor;

  @override
  Widget build(BuildContext context) {
    Widget chip(String label, Color color) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: ConstColor.Primarycolor.withValues(alpha: 0.5),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        chip('Income', incomeColor),
        const SizedBox(width: 18),
        chip('Expense', expenseColor),
      ],
    );
  }
}

class _IncomeExpenseLineChart extends StatelessWidget {
  const _IncomeExpenseLineChart({required this.controller});

  final StatsController controller;

  @override
  Widget build(BuildContext context) {
    final incomeSpots = <FlSpot>[
      for (var i = 0; i < controller.incomeSeries.length; i++)
        FlSpot(i.toDouble(), controller.incomeSeries[i]),
    ];
    final expenseSpots = <FlSpot>[
      for (var i = 0; i < controller.expenseSeries.length; i++)
        FlSpot(i.toDouble(), controller.expenseSeries[i]),
    ];

    final minY = controller.minY;
    final maxY = controller.maxY;

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 5,
        minY: minY,
        maxY: maxY,
        clipData: const FlClipData.all(),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final i = value.round();
                if (i < 0 || i >= StatsController.monthLabels.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    StatsController.monthLabels[i],
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: ConstColor.Primarycolor.withValues(alpha: 0.42),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          getTouchedSpotIndicator: (barData, spotIndexes) {
            final lineColor = barData.gradient != null &&
                    barData.gradient!.colors.isNotEmpty
                ? barData.gradient!.colors.first
                : barData.color ?? ConstColor.Primarycolor;
            final dotFill = lineColor.computeLuminance() > 0.55
                ? ConstColor.Fourthcolor
                : ConstColor.Thirdcolor;
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: lineColor.withValues(alpha: 0.9),
                  strokeWidth: 1,
                  dashArray: const [5, 5],
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, bar, idx) =>
                      FlDotCirclePainter(
                    radius: 5,
                    color: dotFill,
                    strokeWidth: 2,
                    strokeColor: lineColor,
                  ),
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            tooltipMargin: 8,
            maxContentWidth: 160,
            tooltipBorderRadius: BorderRadius.circular(10),
            tooltipBorder: BorderSide.none,
            getTooltipColor: (_) => _StatsChartUi.tooltipBg,
            getTooltipItems: (spots) {
              return spots.map((s) {
                final isIncome = s.barIndex == 0;
                final label = isIncome ? 'Income' : 'Expense';
                return LineTooltipItem(
                  '$label\n\$ ${_formatTooltip(s.y)}',
                  const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ConstColor.Secondaycolor,
                    height: 1.35,
                  ),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: incomeSpots,
            isCurved: true,
            curveSmoothness: 0.22,
            preventCurveOverShooting: true,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ConstColor.Primarycolor,
                Color(0xFF404040),
              ],
            ),
            barWidth: 2.8,
            isStrokeCapRound: true,
            isStrokeJoinRound: true,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ConstColor.Primarycolor.withValues(alpha: 0.34),
                  ConstColor.Primarycolor.withValues(alpha: 0.0),
                ],
              ),
            ),
            dotData: const FlDotData(show: false),
          ),
          LineChartBarData(
            spots: expenseSpots,
            isCurved: true,
            curveSmoothness: 0.22,
            preventCurveOverShooting: true,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _StatsChartUi.expenseMuted,
                Color(0xFF57534E),
              ],
            ),
            barWidth: 2.8,
            isStrokeCapRound: true,
            isStrokeJoinRound: true,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _StatsChartUi.expenseMuted.withValues(alpha: 0.32),
                  _StatsChartUi.expenseMuted.withValues(alpha: 0.0),
                ],
              ),
            ),
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }

  static String _formatTooltip(double v) {
    final n = v.round();
    final s = n.abs().toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) {
        buf.write(',');
      }
      buf.write(s[i]);
    }
    return n < 0 ? '-${buf.toString()}' : buf.toString();
  }
}
