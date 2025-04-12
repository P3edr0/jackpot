import 'package:flutter/material.dart';
import 'package:jackpot/domain/providers/providers.dart';
import 'package:jackpot/theme/custom_themes/theme.dart';
import 'package:jackpot/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: Providers.providers,
    child: MaterialApp(
      title: 'MinerPro',
      theme: JackAppTheme.lightTheme,
      themeMode: ThemeMode.light,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: true,
    ),
  ));
}
