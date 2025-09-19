import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jackpot/components/appbar/appbar.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/bet_resume_card.dart';
import 'package:jackpot/components/cards/championship_jack_card.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/domain/entities/shopping_cart_jackpot_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/jackpot/coupon_select/store/coupon_select_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/store/jackpot_questions_controller.dart';
import 'package:jackpot/presenter/features/jackpot/my_jackpots/pages/my_jackpots/store/my_jackpots_controller.dart';
import 'package:jackpot/presenter/features/jackpot/my_jackpots/pages/my_jackpots_details/store/my_jackpots_details_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/pix_page/store/pix_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/shared/utils/enums/bet_filters.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/shared/utils/routes/route_observer.dart';
import 'package:provider/provider.dart';

import '../../../../../../theme/colors.dart';

class MyJackpotsDetailsPage extends StatefulWidget {
  const MyJackpotsDetailsPage({super.key});

  @override
  State<MyJackpotsDetailsPage> createState() => _MyJackpotsDetailsPageState();
}

class _MyJackpotsDetailsPageState extends State<MyJackpotsDetailsPage>
    with RouteAware {
  late MyJackpotsDetailsController controller;
  final routeObserver = RouteStackObserver.instance();

  @override
  void initState() {
    super.initState();
    controller =
        Provider.of<MyJackpotsDetailsController>(context, listen: false);
    final myJackpotscontroller =
        Provider.of<MyJackpotsController>(context, listen: false);
    final currentFilter = myJackpotscontroller.betStatusFilter;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.setBetStatusFilter(currentFilter);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Selector<MyJackpotsController, bool>(
            selector: (context, controller) => controller.isLoading,
            builder: (context, isLoading, child) =>
                isLoading ? const SizedBox() : const JackBottomNavigationBar()),
        body: Container(
          decoration: const BoxDecoration(color: secondaryColor),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                  child: Selector<MyJackpotsDetailsController, bool>(
                      selector: (_, controller) => controller.isLoading,
                      builder: (context, isLoading, child) {
                        return isLoading
                            ? const Loading()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(children: [
                                  JackAppBar(
                                    title: controller.getPageTitle,
                                    isTransparent: true,
                                    alignment: MainAxisAlignment.start,
                                  ),
                                  SizedBox(
                                    height: Responsive.getHeightValue(26),
                                  ),
                                  Column(children: [
                                    Selector<MyJackpotsDetailsController,
                                            SportJackpotEntity?>(
                                        selector: (_, controller) =>
                                            controller.betSelectedJackpot,
                                        builder: (context, jackpot, child) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: ChampionshipJackCard(
                                                onTap: () async {},
                                                title:
                                                    jackpot!.championship.name,
                                                constraints: constraints,
                                                image: jackpot.banner,
                                                date: jackpot.matchTime,
                                                homeTeam: jackpot.homeTeam,
                                                visitTeam: jackpot.visitorTeam,
                                                isFavorite: true,
                                                setFavorite: () {},
                                              ));
                                        }),
                                    Selector<MyJackpotsDetailsController,
                                            BetFilters>(
                                        selector: (_, controller) =>
                                            controller.betStatusFilter,
                                        builder:
                                            (context, betStatusFilter, child) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              JackSelectableRoundedButton(
                                                  isSelected:
                                                      betStatusFilter.isActive,
                                                  onTap: () => controller
                                                      .setBetStatusFilter(
                                                          BetFilters.active),
                                                  label: 'Ativos'),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              JackSelectableRoundedButton(
                                                  isSelected:
                                                      betStatusFilter.isClosed,
                                                  onTap: () => controller
                                                      .setBetStatusFilter(
                                                          BetFilters.closed),
                                                  label: 'Encerrados'),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              JackSelectableRoundedButton(
                                                  isSelected:
                                                      betStatusFilter.isAwarded,
                                                  onTap: () => controller
                                                      .setBetStatusFilter(
                                                          BetFilters.awarded),
                                                  label: 'Premiados'),
                                            ],
                                          );
                                        }),
                                    SizedBox(
                                      height: Responsive.getHeightValue(16),
                                    ),
                                    Selector<MyJackpotsDetailsController,
                                            List<BetMadeEntity>>(
                                        selector: (_, controller) =>
                                            controller.filteredUserBets,
                                        builder: (context, filteredUserBets,
                                                child) =>
                                            Column(children: [
                                              if (filteredUserBets.isEmpty) ...[
                                                SizedBox(
                                                  height:
                                                      Responsive.getHeightValue(
                                                          16),
                                                ),
                                                SvgPicture.asset(
                                                    height: Responsive
                                                        .getHeightValue(40),
                                                    AppAssets.bagSvg),
                                                SizedBox(
                                                    height: Responsive
                                                        .getHeightValue(6)),
                                                Text('Vazio',
                                                    textAlign: TextAlign.center,
                                                    style: JackFontStyle
                                                        .titleBold
                                                        .copyWith(
                                                            color: mediumGrey)),
                                              ],
                                              ...controller.filteredUserBets
                                                  .map(
                                                (bet) => BetResumeCard(
                                                  couponId: bet.couponNumber,
                                                  createdAt: bet.createdAt,
                                                  awards:
                                                      controller.getBetAwards(),
                                                  status: bet.status!,
                                                  onTap: () {
                                                    final couponsController =
                                                        Provider.of<
                                                                CouponSelectController>(
                                                            context,
                                                            listen: false);
                                                    final paymentController =
                                                        Provider.of<
                                                                PaymentController>(
                                                            context,
                                                            listen: false);
                                                    final questionsController =
                                                        Provider.of<
                                                                JackpotQuestionsController>(
                                                            context,
                                                            listen: false);
                                                    final jackpotController =
                                                        Provider.of<
                                                                JackpotController>(
                                                            context,
                                                            listen: false);
                                                    if (bet.status!
                                                            .isWaitingPayment &&
                                                        bet.temporaryBet !=
                                                            null &&
                                                        bet.temporaryBet!
                                                                .pixQrCode !=
                                                            null) {
                                                      paymentController
                                                          .setTempPaymentId(bet
                                                              .temporaryBet!
                                                              .paymentId!);
                                                      jackpotController
                                                          .setSelectedJackpot([
                                                        controller
                                                            .betSelectedJackpot!
                                                      ]);
                                                      final handledJackpot =
                                                          JackpotAggregateEntity(
                                                              couponPrice: bet
                                                                  .temporaryBet!
                                                                  .couponPrice,
                                                              couponsQuantity: bet
                                                                  .temporaryBet!
                                                                  .couponQuantity,
                                                              jackpot: controller
                                                                  .betSelectedJackpot!);
                                                      questionsController
                                                          .setIsQuestionsPreview(
                                                        newIsQuestionPreview:
                                                            false,
                                                        newJackpots: [
                                                          handledJackpot
                                                        ],
                                                      );
                                                      jackpotController
                                                          .setTemporaryBets([
                                                        bet.temporaryBet!
                                                      ]);
                                                      final pixController =
                                                          Provider.of<
                                                                  PixController>(
                                                              context,
                                                              listen: false);
                                                      pixController
                                                          .setIsPixPreview(
                                                              true);

                                                      final tempBet =
                                                          bet.temporaryBet!;
                                                      final paymentValue =
                                                          tempBet.couponPrice *
                                                              tempBet
                                                                  .couponQuantity;

                                                      final newPix = PixEntity(
                                                          id: tempBet
                                                              .paymentId!,
                                                          value: tempBet
                                                                  .paymentValue ??
                                                              paymentValue,
                                                          qrCode: tempBet
                                                              .pixQrCode!,
                                                          expireAt: tempBet
                                                              .createdAt!
                                                              .add(const Duration(
                                                                  minutes:
                                                                      1439)),
                                                          copyPaste: tempBet
                                                              .pixCopyPaste!);
                                                      pixController
                                                          .setPix(newPix);
                                                      couponsController
                                                          .setTotalValueComponents(
                                                              tempBet
                                                                  .couponPrice,
                                                              tempBet
                                                                  .couponQuantity);
                                                      Navigator.pushNamed(
                                                          context,
                                                          AppRoutes.qrCodePix);
                                                      return;
                                                    }

                                                    if (bet.status!
                                                        .isWaitingAnswer) {
                                                      final tempBet =
                                                          bet.temporaryBet!;

                                                      couponsController
                                                          .setTotalValueComponents(
                                                              tempBet
                                                                  .couponPrice,
                                                              tempBet
                                                                  .couponQuantity);
                                                      paymentController
                                                          .setTempPaymentId(
                                                              tempBet
                                                                  .paymentId!);
                                                      jackpotController
                                                          .setSelectedJackpot([
                                                        controller
                                                            .betSelectedJackpot!
                                                      ]);
                                                      final handledJackpot =
                                                          JackpotAggregateEntity(
                                                              couponPrice: bet
                                                                  .temporaryBet!
                                                                  .couponPrice,
                                                              couponsQuantity: bet
                                                                  .temporaryBet!
                                                                  .couponQuantity,
                                                              jackpot: controller
                                                                  .betSelectedJackpot!);
                                                      questionsController
                                                          .setIsQuestionsPreview(
                                                        newIsQuestionPreview:
                                                            false,
                                                        newJackpots: [
                                                          handledJackpot
                                                        ],
                                                      );

                                                      Navigator.pushNamed(
                                                          context,
                                                          AppRoutes
                                                              .jackpotQuestions);
                                                      return;
                                                    }

                                                    jackpotController
                                                        .setSelectedJackpot([
                                                      controller
                                                          .betSelectedJackpot!
                                                    ]);
                                                    final handledJackpot =
                                                        JackpotAggregateEntity(
                                                            couponPrice: 00,
                                                            couponsQuantity: 1,
                                                            jackpot: controller
                                                                .betSelectedJackpot!);
                                                    questionsController
                                                        .setIsQuestionsPreview(
                                                            newIsQuestionPreview:
                                                                true,
                                                            newJackpots: [
                                                              handledJackpot
                                                            ],
                                                            betQuestions:
                                                                bet.answers);
                                                    Navigator.pushNamed(
                                                        context,
                                                        AppRoutes
                                                            .jackpotQuestions);
                                                  },
                                                ),
                                              )
                                            ])),
                                  ])
                                ]));
                      })),
            ),
          ),
        ));
  }
}
