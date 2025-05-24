import 'package:flutter/material.dart';
import 'package:jackpot/domain/providers/providers.dart';
import 'package:jackpot/i18n/jack_localizations.dart';
import 'package:jackpot/i18n/locale_controller.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';
import 'package:jackpot/theme/custom_themes/theme.dart';
import 'package:provider/provider.dart';

import '../shared/utils/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  print(JackEnvironment
      .apiUrl); // Output: https://hml-apijackpot.uzerpass.com.br/api/
  final localeProvider = LocaleController.instance();

  runApp(MultiProvider(
    providers: Providers.providers,
    child: MaterialApp(
      title: 'MinerPro',
      theme: JackAppTheme.lightTheme,
      themeMode: ThemeMode.light,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: true,
      locale: localeProvider.locale,
      localizationsDelegates: JackLocalizations.localizationsDelegates,
      supportedLocales: JackLocalizations.supportedLocales,
    ),
  ));
}
