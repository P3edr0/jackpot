import 'package:jackpot/presenter/features/home/home_page.dart';
import 'package:jackpot/presenter/features/splash/splash_page.dart';

class AppRoutes {
  static const splash = '/';
  static const homePage = '/home';

  static final routes = {
    AppRoutes.splash: (ctx) => const SplashPage(),
    AppRoutes.homePage: (ctx) => const HomePage(),
  };
}
