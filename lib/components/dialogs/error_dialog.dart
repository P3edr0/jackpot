import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';

class ErrorDialog {
  const ErrorDialog();

  static Future show(String title, String content, BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title, textAlign: TextAlign.center),
              content: Text(content, textAlign: TextAlign.center),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                JackRoundedButton(
                  height: 50,
                  width: Responsive.getHeightValue(140),
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    "Fechar",
                    textAlign: TextAlign.center,
                    style:
                        JackFontStyle.titleBold.copyWith(color: secondaryColor),
                  ),
                ),
              ],
            ));
  }
}
