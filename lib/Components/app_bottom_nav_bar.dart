import 'package:flutter/material.dart';

import '../utils/constcolors.dart';

/// One tab in [AppBottomNavBar]. Use [AppBottomNavBar.defaultDestinations] or pass a custom list.
class AppBottomNavDestination {
  const AppBottomNavDestination({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  final String label;
  final IconData activeIcon;
  final IconData inactiveIcon;
}

/// White bottom bar with a light top divider, icon + label per tab.
/// Reuse on any screen: own the selected index in parent state and switch routes/bodies in [onTap].
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.destinations = AppBottomNavBar.defaultDestinations,
  }) : assert(destinations.length > 0);

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppBottomNavDestination> destinations;

  static const List<AppBottomNavDestination> defaultDestinations = [
    AppBottomNavDestination(
      label: 'Home',
      activeIcon: Icons.home_rounded,
      inactiveIcon: Icons.home_outlined,
    ),
    AppBottomNavDestination(
      label: 'Statistics',
      activeIcon: Icons.bar_chart_rounded,
      inactiveIcon: Icons.bar_chart_outlined,
    ),
    AppBottomNavDestination(
      label: 'Wallet',
      activeIcon: Icons.account_balance_wallet,
      inactiveIcon: Icons.account_balance_wallet_outlined,
    ),
    AppBottomNavDestination(
      label: 'Profile',
      activeIcon: Icons.person,
      inactiveIcon: Icons.person_outline_rounded,
    ),
  ];

  static const _iconSize = 24.0;
  static const _labelSize = 11.0;

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    return Material(
      color: ConstColor.Secondaycolor,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: ConstColor.bottomNavTopBorder, width: 1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: safeBottom),
          child: SizedBox(
            height: 62,
            child: Row(
              children: List.generate(destinations.length, (index) {
                final d = destinations[index];
                final selected = index == currentIndex;
                final color =
                    selected ? ConstColor.bottomNavActive : ConstColor.bottomNavInactive;

                return Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onTap(index),
                      splashColor: ConstColor.bottomNavInactive.withValues(alpha: 0.12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            selected ? d.activeIcon : d.inactiveIcon,
                            size: _iconSize,
                            color: color,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            d.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: _labelSize,
                              fontWeight:
                                  selected ? FontWeight.w700 : FontWeight.w400,
                              height: 1.1,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
