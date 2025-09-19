import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/outline_button.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';

class ConfirmDialog {
  const ConfirmDialog();

  static Future<bool?> show(String title, String content, BuildContext context,
      VoidCallback confirmCallback) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title, textAlign: TextAlign.center),
              content: Text(content, textAlign: TextAlign.center),
              actions: [
                JackOutlineButton(
                  height: 50,
                  width: Responsive.getHeightValue(120),
                  onTap: () => Navigator.of(context).pop(),
                  borderColor: darkBlue,
                  child: Text(
                    "Voltar",
                    textAlign: TextAlign.center,
                    style: JackFontStyle.titleBold.copyWith(color: darkBlue),
                  ),
                ),
                JackRoundedButton(
                  height: 50,
                  width: Responsive.getHeightValue(150),
                  onTap: confirmCallback,
                  child: Text(
                    "Confirmar",
                    textAlign: TextAlign.center,
                    style:
                        JackFontStyle.titleBold.copyWith(color: secondaryColor),
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
