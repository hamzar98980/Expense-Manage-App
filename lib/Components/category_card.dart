import 'package:flutter/material.dart';

import '../utils/constcolors.dart';

/// Rounded category tile: [name] + [typeLabel] on separate lines, then amount; [icon] is a corner watermark.
/// Use [backgroundColor] for expense vs income surfaces (e.g. [ConstColor.Thirdcolor] / [ConstColor.Fourthcolor]).
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.name,
    required this.typeLabel,
    required this.amount,
    required this.icon,
    required this.backgroundColor,
    this.textColor = ConstColor.Primarycolor,
    this.borderRadius = 30,
  });

  /// First line (e.g. “Grocery”).
  final String name;
  /// Second line — category kind (e.g. “Expense”, “Income”).
  final String typeLabel;
  final String amount;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  /// Same corner placement as account cards; icon is rotated; circle is not.
  static const _watermarkOpacity = 0.16;
  static const _watermarkSize = 70.0;
  static const _watermarkCircleSize = 100.0;
  static const _watermarkRotation = -0.42;

  static const _nameSize = 15.0;
  static const _typeSize = 12.0;
  static const _nameTypeGap = 2.0;
  static const _amountSize = 17.0;
  static const _titleBlockAmountGap = 17.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: -26,
            right: -32,
            child: IgnorePointer(
              child: SizedBox(
                width: _watermarkCircleSize,
                height: _watermarkCircleSize,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: _watermarkCircleSize,
                      height: _watermarkCircleSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: textColor.withValues(alpha: 0.1),
                      ),
                    ),
                    Transform.rotate(
                      angle: _watermarkRotation,
                      child: Opacity(
                        opacity: _watermarkOpacity,
                        child: Icon(
                          icon,
                          size: _watermarkSize,
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: _nameSize,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: _nameTypeGap),
                  Text(
                    typeLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: _typeSize,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      color: textColor.withValues(alpha: 0.62),
                    ),
                  ),
                  SizedBox(height: _titleBlockAmountGap),
                  Text(
                    amount,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: _amountSize,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
