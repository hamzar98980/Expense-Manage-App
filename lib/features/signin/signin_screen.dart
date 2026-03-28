import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../components/rounded_primary_button.dart';
import '../../utils/constcolors.dart';
import 'signin_controller.dart';

class SigninScreen extends GetView<SigninController> {
  const SigninScreen({super.key});

  static const _horizontalPadding = 24.0;
  static const _fieldRadius = 14.0;
  static const _panelBottomRadius = 28.0;
  static const _titleFontSize = 30.0;
  static const _illustrationAsset = 'assets/images/opening_illustraion.png';
  static const _illustrationHeight = 210.0;
  static const _panelBackground = Color(0xFFE8EDF3);

  InputDecoration _fieldDecoration({
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: ConstColor.Secondaycolor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_fieldRadius),
        borderSide: const BorderSide(color: ConstColor.Primarycolor, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_fieldRadius),
        borderSide: BorderSide(color: Colors.grey.shade400, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_fieldRadius),
        borderSide: const BorderSide(color: ConstColor.Primarycolor, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: ConstColor.Secondaycolor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: _panelBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(_panelBottomRadius),
                          bottomRight: Radius.circular(_panelBottomRadius),
                        ),
                      ),
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            _horizontalPadding,
                            4,
                            _horizontalPadding,
                            28,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () => Get.back<void>(),
                                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                                  color: ConstColor.Primarycolor,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 40,
                                    minHeight: 40,
                                  ),
                                ),
                              ),
                              Center(
                                child: Image.asset(
                                  _illustrationAsset,
                                  height: _illustrationHeight,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: _titleFontSize,
                                  fontWeight: FontWeight.w800,
                                  height: 1.15,
                                  color: ConstColor.Primarycolor,
                                ),
                              ),
                              const SizedBox(height: 24),
                              TextField(
                                controller: controller.emailController,
                                style: const TextStyle(
                                  color: ConstColor.Primarycolor,
                                ),
                                cursorColor: ConstColor.Primarycolor,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                decoration: _fieldDecoration(
                                  hintText: 'Email address',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Obx(
                                () => TextField(
                                  controller: controller.passwordController,
                                  style: const TextStyle(
                                    color: ConstColor.Primarycolor,
                                  ),
                                  cursorColor: ConstColor.Primarycolor,
                                  obscureText: controller.obscurePassword.value,
                                  textInputAction: TextInputAction.done,
                                  decoration: _fieldDecoration(
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      onPressed: controller.togglePasswordVisibility,
                                      icon: Icon(
                                        controller.obscurePassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: ConstColor.Primarycolor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        _horizontalPadding,
                        28,
                        _horizontalPadding,
                        24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RoundedPrimaryButton(
                            label: 'Sign in',
                            onPressed: () =>
                                Get.offAllNamed<void>(AppRoutes.home),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    height: 1.45,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      Get.toNamed<void>(AppRoutes.signup),
                                  child: const Text(
                                    'Create account',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      height: 1.45,
                                      color: ConstColor.Primarycolor,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      decorationColor: ConstColor.Primarycolor,
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
            ),
          ],
        ),
      ),
    );
  }
}
