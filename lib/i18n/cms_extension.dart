import 'dart:developer';

import 'package:jackpot/i18n/locale_controller.dart';
import 'package:localization/localization.dart';

extension CmsExtension on String {
  String cms([List args = const []]) {
    final controller = LocaleController.instance();

    final data = controller.translate(this) ??
        i18n(args.map((e) {
          log(e.toString(), name: 'Arguments');
          return e.toString();
        }).toList());
    if (data == this) {
      log(data, name: "vazio:");

      controller.update();
    }
    return data;
  }
}
