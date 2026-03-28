import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../components/rounded_primary_button.dart';
import '../../components/rounded_secondary_outline_button.dart';
import '../../utils/constcolors.dart';

class OpeningScreen extends StatelessWidget {
  const OpeningScreen({super.key});

  static const _illustrationAsset = 'assets/images/opening_illustraion.png';

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 24.0;
    const bottomPadding = 32.0;
    const buttonGap = 12.0;

    return Scaffold(
      backgroundColor: ConstColor.Secondaycolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final illustrationSize = (constraints.maxWidth * 0.72)
                        .clamp(240.0, 340.0)
                        .toDouble();
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: illustrationSize,
                              height: illustrationSize,
                              child: Center(
                                child: Image.asset(
                                  _illustrationAsset,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              'Explore the app',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                height: 1.15,
                                color: ConstColor.Primarycolor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Now your finances are in one place and always under control',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey.shade600,
                                    height: 1.4,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              RoundedPrimaryButton(
                label: 'Sign In',
                onPressed: () => Get.toNamed<void>(AppRoutes.signin),
              ),
              const SizedBox(height: buttonGap),
              RoundedSecondaryOutlineButton(
                label: 'Create account',
                onPressed: () => Get.toNamed<void>(AppRoutes.signup),
              ),
              const SizedBox(height: bottomPadding),
            ],
          ),
        ),
      ),
    );
  }
}
