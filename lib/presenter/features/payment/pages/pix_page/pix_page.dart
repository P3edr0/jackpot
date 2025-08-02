import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jackpot/components/appbar/appbar.dart';
import 'package:jackpot/components/buttons/outline_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/dialogs/info_dialog.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/components/loadings/loading_content.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/pix_page/store/pix_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/formatters/date_formatter.dart';
import 'package:jackpot/shared/utils/formatters/money_formatters.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class PixPage extends StatefulWidget {
  const PixPage({super.key});

  @override
  State<PixPage> createState() => _PixPageState();
}

class _PixPageState extends State<PixPage> {
  late PaymentController paymentController;
  late PixController pixController;
  late JackpotController jackpotController;

  @override
  void initState() {
    super.initState();
    paymentController = Provider.of<PaymentController>(context, listen: false);
    pixController = Provider.of<PixController>(context, listen: false);
    jackpotController = Provider.of<JackpotController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      pixController.addListener(successRedirect);
      bool isSameValue =
          pixController.pix?.value == paymentController.paymentValue;
      if (pixController.pix == null || !isSameValue) {
        pixController.setPix(null, false);
        pixController.setLoading(true);
        final PixEntity? pix;
        pix = await paymentController.generatePix();
        final hasError = paymentController.hasError;
        pixController.setPix(pix, hasError);
        if (hasError && context.mounted) {
          Navigator.pop(context);

          await InfoDialog.show(
              'Erro',
              "Falha ao gerar Qr code.\n Por favor tente novamente mais tarde. ",
              context);
        } else {
          final userDocument = paymentController.userDocument;
          jackpotController.startTemporaryBets(pix, userDocument);
        }
        pixController.setLoading(false);
      }
    });
    if (pixController.pix != null) {
      pixController.startPixTimer();
    }
  }

  void successRedirect() {
    if (pixController.pixStatus?.isSuccess ?? false) {
      pixController.cancelTimers();

      Navigator.pushNamed(context, AppRoutes.jackpotQuestions);
      pixController.removeListener(successRedirect);
    }
  }

  @override
  void dispose() {
    pixController.cancelTimers();

    pixController.removeListener(successRedirect);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Selector<PixController, bool>(
      selector: (p0, ctrl) => ctrl.isLoading,
      builder: (context, loading, child) => loading
          ? const Loading()
          : Consumer<PixController>(
              builder: (context, controller, child) => Container(
                  decoration: const BoxDecoration(color: secondaryColor),
                  child: SafeArea(
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                        const JackAppBar(
                          title: 'Pagamento PIX',
                        ),
                        SizedBox(height: Responsive.getHeightValue(16)),
                        controller.pix == null
                            ? const SizedBox()
                            : Padding(
                                padding: EdgeInsets.all(
                                    Responsive.getHeightValue(16)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: Responsive.getHeightValue(8)),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Responsive.getHeightValue(8),
                                        vertical: Responsive.getHeightValue(16),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: darkBlue, width: 2),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: controller.pixStatus!
                                                    .getBackgroundColor()),
                                            child: Text(
                                              controller.pixStatus!.getLabel(),
                                              style: JackFontStyle.titleBold
                                                  .copyWith(
                                                      color: controller
                                                          .pixStatus!
                                                          .getLabelColor()),
                                            ),
                                          ),
                                          SizedBox(
                                              height: Responsive.getHeightValue(
                                                  10)),
                                          if (controller.pixStatus!.isWaiting)
                                            Text(
                                              JackDateFormat.expireTimeFormat(
                                                  controller.pix!.expireAt),
                                              style: JackFontStyle.bodyLargeBold
                                                  .copyWith(color: alertColor),
                                            ),
                                          SizedBox(
                                              height: Responsive.getHeightValue(
                                                  16)),
                                          Text(
                                            'Scaneie o QR code',
                                            style: JackFontStyle.titleBold,
                                          ),
                                          SizedBox(
                                            height:
                                                Responsive.getHeightValue(200),
                                            width:
                                                Responsive.getHeightValue(200),
                                            child: Image.network(
                                              controller.pix!.qrCode,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                final value = loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null;
                                                return LoadingContent(
                                                    value: value);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  Responsive.getHeightValue(8)),
                                          Text(
                                            MoneyFormat.toReal(controller
                                                    .pix?.value
                                                    .toString() ??
                                                "00"),
                                            style: JackFontStyle.titleBold,
                                          ),
                                          SizedBox(
                                              height: Responsive.getHeightValue(
                                                  16)),
                                          Container(
                                            width: double.infinity,
                                            height:
                                                Responsive.getHeightValue(150),
                                            padding: EdgeInsets.all(
                                                Responsive.getHeightValue(8)),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: darkBlue, width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Text(
                                                controller.pix?.copyPaste ??
                                                    "Aguarde...",
                                                style: JackFontStyle.bodyLarge,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height: Responsive.getHeightValue(16)),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        JackOutlineButton(
                                            height: 44,
                                            radius: 30,
                                            borderColor: darkBlue,
                                            borderWidth: 2,
                                            onTap: () async {
                                              pixController.cancelTimers();
                                              Navigator.pushNamed(context,
                                                  AppRoutes.jackpotQuestions);

                                              return;
                                              Clipboard.setData(ClipboardData(
                                                  text: controller
                                                      .pix!.copyPaste));
                                              InfoDialog.closeAuto(
                                                  'Sucesso',
                                                  'Pix copiado para área de transferência',
                                                  context);
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.copy,
                                                  color: darkBlue,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Copiar código',
                                                  style: JackFontStyle
                                                      .bodyLargeBold
                                                      .copyWith(
                                                          color: darkBlue),
                                                ),
                                              ],
                                            )),
                                        const Spacer()
                                      ],
                                    ),
                                    SizedBox(
                                        height: Responsive.getHeightValue(16)),
                                    if (pixController.pixStatus?.isSuccess ??
                                        false)
                                      Row(
                                        children: [
                                          const Spacer(),
                                          JackSelectableRoundedButton(
                                              height: 44,
                                              withShader: true,
                                              radius: 30,
                                              isSelected: true,
                                              borderColor: darkBlue,
                                              borderWidth: 2,
                                              onTap: () {
                                                pixController.cancelTimers();
                                                Navigator.pushNamed(context,
                                                    AppRoutes.jackpotQuestions);
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Responder Jackpot',
                                                    style: JackFontStyle
                                                        .bodyLargeBold
                                                        .copyWith(
                                                            color:
                                                                secondaryColor),
                                                  ),
                                                ],
                                              )),
                                          const Spacer()
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                      ])))),
            ),
    ));
  }
}
