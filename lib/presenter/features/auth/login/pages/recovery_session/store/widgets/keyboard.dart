import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.getHeightValue(16)),
      child: Column(
        children: [
          SizedBox(height: Responsive.getHeightValue(20)),
          const Expanded(
            child: Row(
              children: [
                KeyboardButton(value: '1'),
                SizedBox(
                  width: 10,
                ),
                KeyboardButton(value: '2'),
                SizedBox(
                  width: 10,
                ),
                KeyboardButton(value: '3'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(
            child: Row(
              children: [
                KeyboardButton(value: '4'),
                SizedBox(
                  width: 10,
                ),
                KeyboardButton(value: '5'),
                SizedBox(
                  width: 10,
                ),
                KeyboardButton(value: '6'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(
            child: Row(
              children: [
                KeyboardButton(value: '7'),
                SizedBox(
                  width: 10,
                ),
                KeyboardButton(value: '8'),
                SizedBox(
                  width: 10,
                ),
                KeyboardButton(value: '9'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(
            child: Row(
              children: [
                KeyboardButton(
                  value: 'backspace',
                  icon: Icon(
                    Icons.backspace,
                    size: 20,
                    color: darkBlue,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                KeyboardButton(value: '0'),
                SizedBox(
                  width: 10,
                ),
                KeyboardButton(
                    value: 'done',
                    icon: Icon(
                      Icons.done_all,
                      size: 20,
                      color: darkBlue,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KeyboardButton extends StatelessWidget {
  const KeyboardButton({super.key, required this.value, this.icon});
  final String value;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    final bool haveIcon = icon != null;
    return Expanded(
      child: InkWell(
        onTap: () async {
          final controller =
              Provider.of<CoreController>(context, listen: false);
          if (haveIcon) {
            if (value == 'done') {
              final response = await controller.loginSession();
              if (response != null) {
                ErrorDialog.show(
                    "Falha ao fazer login", "Senha inválida", context);
              } else {
                if (context.mounted) {
                  controller.clearRecovererPasswordContent();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.home, (route) => false);
                }
              }
            } else {
              controller.setRecoverPassword(value, true);
            }
          } else {
            final length = controller.setRecoverPassword(value);
            if (length == 6) {
              final response = await controller.loginSession();
              if (response != null) {
                ErrorDialog.show(
                    "Falha ao fazer login", "Senha inválida", context);
              } else {
                if (context.mounted) {
                  controller.clearRecovererPasswordContent();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.home, (route) => false);
                }
              }
            }
          }
          log(value);
        },
        child: Container(
          decoration: BoxDecoration(
              color: secondaryColor,
              boxShadow: const [
                BoxShadow(
                    color: mediumGrey,
                    offset: Offset(0, 1),
                    blurRadius: 0.5,
                    spreadRadius: 0.5),
                BoxShadow(
                    color: lightGrey,
                    offset: Offset(0, -1),
                    blurRadius: 0.5,
                    spreadRadius: 0.5)
              ],
              borderRadius: BorderRadius.circular(16)),
          alignment: Alignment.center,
          child: haveIcon
              ? icon
              : Text(
                  value,
                  style: JackFontStyle.h3Bold.copyWith(color: darkBlue),
                ),
        ),
      ),
    );
  }
}
