import 'package:get/get.dart';

/// Placeholder monthly series; swap for repository later.
class StatsController extends GetxController {
  static const List<String> monthLabels = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
  ];

  /// Income per month (same order as [monthLabels]).
  final List<double> incomeSeries = const [
    14200,
    9000,
    15500,
    19200,
    800,
    12200,
  ];

  /// Expense per month.
  final List<double> expenseSeries = const [
    9200,
    10400,
    8900,
    12100,
    9800,
    13200,
  ];

  double get maxY {
    final all = [...incomeSeries, ...expenseSeries];
    final m = all.reduce((a, b) => a > b ? a : b);
    return m * 1.12;
  }

  double get minY => 0;

  double get netLastMonth =>
      incomeSeries.last - expenseSeries.last;

  double get netChangePercent {
    if (incomeSeries.length < 2) return 0;
    final prev = incomeSeries[incomeSeries.length - 2] -
        expenseSeries[expenseSeries.length - 2];
    final cur = netLastMonth;
    if (prev == 0) return 0;
    return ((cur - prev) / prev.abs()) * 100;
  }

  /// Month-over-month change for last income point (for footer).
  double get incomeMomPercent {
    if (incomeSeries.length < 2) return 0;
    final prev = incomeSeries[incomeSeries.length - 2];
    final cur = incomeSeries.last;
    if (prev == 0) return 0;
    return ((cur - prev) / prev) * 100;
  }

  /// Month-over-month change for last expense point (for footer).
  double get expenseMomPercent {
    if (expenseSeries.length < 2) return 0;
    final prev = expenseSeries[expenseSeries.length - 2];
    final cur = expenseSeries.last;
    if (prev == 0) return 0;
    return ((cur - prev) / prev) * 100;
  }
}
