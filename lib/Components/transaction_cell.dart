import 'package:flutter/material.dart';

import '../utils/constcolors.dart';

class TransactionCell extends StatelessWidget {
  const TransactionCell({
    super.key,
    required this.title,
    required this.accountType,
    required this.amount,
    required this.icon,
    required this.backgroundColor,
    required this.isIncome,
  });

  final String title;
  final String accountType;
  final String amount;
  final IconData icon;
  final Color backgroundColor;
  /// When true, shows an upward arrow watermark; when false, downward (expense).
  final bool isIncome;

  // static const _onCard = ConstColor.Primarycolor;
  Color get _onCard =>
      isIncome ? ConstColor.Secondaycolor : ConstColor.Primarycolor;

  Color get iconColor => isIncome ? ConstColor.Primarycolor : ConstColor.Secondaycolor;

  @override
  Widget build(BuildContext context) {
    final watermarkIcon =
        isIncome ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;

    return Material(
      color: backgroundColor,
      elevation: 2,
      shadowColor: Colors.black26,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: ConstColor.Primarycolor.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: 96,
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.07,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.centerRight,
                  child: Icon(
                    watermarkIcon,
                    size: 512,
                    color: _onCard,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration:  BoxDecoration(
                    color: _onCard,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _onCard,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        accountType,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _onCard.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  amount,
                  style:  TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _onCard,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

