import 'package:flutter/material.dart';

import '../utils/constcolors.dart';

/// Rounded category tile: title + outline icon on top row, amount below.
/// Use [backgroundColor] for expense vs income surfaces (e.g. [ConstColor.Thirdcolor] / [ConstColor.Fourthcolor]).
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.backgroundColor,
    this.textColor = ConstColor.Primarycolor,
    this.borderRadius = 30,
  });

  final String title;
  final String amount;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  /// Icons read as a light watermark behind the text.
  static const _iconBackgroundOpacity = 0.22;
  static const _titleSize = 15.0;
  static const _amountSize = 17.0;
  static const _iconSize = 46.0;
  static const _titleAmountGap = 8.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: _titleSize,
                        fontWeight: FontWeight.w500,
                        height: 1.15,
                        color: textColor,
                      ),
                    ),
                  ),
                  Icon(
                    icon,
                    size: _iconSize,
                    color: textColor.withValues(alpha: _iconBackgroundOpacity),
                  ),
                ],
              ),
              SizedBox(height: _titleAmountGap),
              Text(
                amount,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: _amountSize,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
