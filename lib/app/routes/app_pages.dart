import 'package:get/get.dart';

import '../../features/home/home_binding.dart';
import '../../features/home/home_screen.dart';
import '../../features/opening/opening_binding.dart';
import '../../features/opening/opening_screen.dart';
import '../../features/accounts/accounts_binding.dart';
import '../../features/accounts/accounts_screen.dart';
import '../../features/accounts/create_account_binding.dart';
import '../../features/accounts/create_account_screen.dart';
import '../../features/signin/signin_binding.dart';
import '../../features/signin/signin_screen.dart';
import '../../features/signup/signup_binding.dart';
import '../../features/signup/signup_screen.dart';
import '../../features/splash/splash_binding.dart';
import '../../features/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: SplashScreen.new,
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.opening,
      page: OpeningScreen.new,
      binding: OpeningBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: SignupScreen.new,
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.signin,
      page: SigninScreen.new,
      binding: SigninBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: HomeScreen.new,
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.accounts,
      page: AccountsScreen.new,
      binding: AccountsBinding(),
    ),
    GetPage(
      name: AppRoutes.createAccount,
      page: CreateAccountScreen.new,
      binding: CreateAccountBinding(),
    ),
  ];
}
