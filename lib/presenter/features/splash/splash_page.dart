import 'package:flutter/material.dart';
import 'package:jackpot/presenter/features/home/home_page.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/text_theme/colors.dart';
import 'package:jackpot/utils/app_assets.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      Responsive.defineSize(size, pixelRatio: size.aspectRatio);
      Future.delayed(const Duration(seconds: 3), () async {
        redirect();
      });
    });
  }

  redirect() async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(gradient: secondaryGradient),
        child: Center(child: Lottie.asset(AppAssets.jackpotLootie)),
      ))),
    );
  }
}
