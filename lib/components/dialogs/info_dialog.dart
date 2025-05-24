import 'package:flutter/material.dart';
import 'package:jackpot/theme/colors.dart';

class InfoDialog {
  const InfoDialog();

  static Future show(String title, String content, BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title, textAlign: TextAlign.center),
              content: Text(content, textAlign: TextAlign.center),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkBlue,
                    foregroundColor: secondaryColor,
                  ),
                  child: const Text('Fechar'),
                ),
              ],
            ));
  }

  static Future closeAuto(
      String title, String content, BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          });
          return AlertDialog(
            title: Text(title, textAlign: TextAlign.center),
            content: Text(content, textAlign: TextAlign.center),
          );
        });
  }
}
