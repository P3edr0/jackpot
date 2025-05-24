import 'package:flutter/material.dart';
import 'package:jackpot/theme/colors.dart';

class PasswordIcon extends StatelessWidget {
  const PasswordIcon({super.key, required this.passwordLength});
  final int passwordLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getIcon(passwordLength > 0),
        getIcon(passwordLength > 1),
        getIcon(passwordLength > 2),
        getIcon(passwordLength > 3),
        getIcon(passwordLength > 4),
        getIcon(passwordLength > 5),
      ],
    );
  }
}

Widget getIcon(bool isSelected) {
  if (isSelected) {
    return const Icon(
      Icons.circle,
      size: 20,
      color: darkBlue,
    );
  }
  return const Icon(
    Icons.circle_outlined,
    size: 20,
    color: darkBlue,
  );
}
