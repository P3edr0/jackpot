import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/outline_button.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';

class QuitAppDialog {
  const QuitAppDialog();

  static Future<bool> show(
      String title, String content, BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title, textAlign: TextAlign.center),
              content: Text(content, textAlign: TextAlign.center),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                JackRoundedButton(
                  height: 50,
                  width: Responsive.getHeightValue(120),
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text(
                    "Voltar",
                    textAlign: TextAlign.center,
                    style:
                        JackFontStyle.titleBold.copyWith(color: secondaryColor),
                  ),
                ),
                JackOutlineButton(
                  height: 50,
                  width: Responsive.getHeightValue(100),
                  onTap: () => Navigator.of(context).pop(true),
                  borderColor: darkBlue,
                  child: Text(
                    "Sair",
                    textAlign: TextAlign.center,
                    style: JackFontStyle.titleBold.copyWith(color: darkBlue),
                  ),
                ),
              ],
            ));
  }

  static Future closeAuto(
      String title, String content, BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Durations.extralong4, () {
            if (context.mounted) {
              Navigator.of(context).pop(false);
            }
          });
          return AlertDialog(
            title: Text(title, textAlign: TextAlign.center),
            content: Text(content, textAlign: TextAlign.center),
          );
        });
  }
}
