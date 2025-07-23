import 'package:flutter/material.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/shopping_cart/store/shopping_cart_controller.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/app_assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    final controller = Provider.of<CoreController>(context, listen: false);
    final shoppingCartController =
        Provider.of<ShoppingCartController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getSession();
      shoppingCartController.getLocalCart(null);
      final size = MediaQuery.of(context).size;
      Responsive.defineSize(size, pixelRatio: size.aspectRatio);
      Future.delayed(const Duration(seconds: 2), () async {
        redirect();
      });
    });
  }

  redirect() async {
    await Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: veryDarkBlue,
      body: SafeArea(
          child: Center(
              child: Opacity(
        opacity: 0.9,
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(color: veryDarkBlue),
          child: Image.asset(
            colorBlendMode: BlendMode.hardLight,
            AppAssets.splash,
            fit: BoxFit.contain,
          ),
        ),
      ))),
    );
  }
}
