import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/presenter/features/home/pages/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/sports_filter/filter_item.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/sports.dart';
import 'package:pagseguro_card_encrypt/pagseguro_card_encrypt.dart';
import 'package:provider/provider.dart';

class SportsFilter extends StatelessWidget {
  const SportsFilter({super.key, required this.constraints});
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) => SizedBox(
          width: constraints.maxWidth,
          height: Responsive.getHeightValue(75),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: SportsOptions.values.map((sport) {
                final iconName = sport.name;
                final iconLabel = sport.translateName();
                if (controller.selectedSport.name == sport.name) {
                  return FilterItem(
                    iconName: iconName,
                    label: iconLabel,
                    isSelected: true,
                    onTap: () {},
                  );
                } else {
                  return FilterItem(
                    iconName: iconName,
                    label: iconLabel,
                    onTap: () {
                      const publicKey =
                          'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAr+ZqgD892U9/HXsa7XqBZUayPquAfh9xx4iwUbTSUAvTlmiXFQNTp0Bvt/5vK2FhMj39qSv1zi2OuBjvW38q1E374nzx6NNBL5JosV0+SDINTlCG0cmigHuBOyWzYmjgca+mtQu4WczCaApNaSuVqgb8u7Bd9GCOL4YJotvV5+81frlSwQXralhwRzGhj/A57CGPgGKiuPT+AOGmykIGEZsSD9RKkyoKIoc0OS8CPIzdBOtTQCIwrLn2FxI83Clcg55W8gkFSOS6rWNbG5qFZWMll6yl02HtunalHmUlRUL66YeGXdMDC2PuRcmZbGO5a/2tbVppW6mfSWG3NPRpgwIDAQAB';
                      final encryptedCardData = encryptCard(
                        cardNumber: '4539620659922097',
                        cardHolderName: 'João Silva',
                        cardSecurityCode: '123',
                        cardExpMonth: '12',
                        cardExpYear: '2026',
                        publicKey: publicKey,
                      );

                      log('Dados do cartão criptografados: $encryptedCardData');

                      controller.setSelectedSport(sport);
                    },
                    isSelected: false,
                  );
                }
              }).toList(),
            ),
          )),
    );
  }
}
