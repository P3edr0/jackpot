import 'package:flutter/material.dart';
import 'package:jackpot/components/appbar/appbar.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/match_card.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/jackpot/coupon_select/store/coupon_select_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/store/jackpot_questions_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/coupons_base_quantity.dart';
import 'package:jackpot/shared/utils/formatters/money_formatters.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../theme/colors.dart';

class CouponSelectPage extends StatefulWidget {
  const CouponSelectPage({super.key});

  @override
  State<CouponSelectPage> createState() => _CouponSelectPageState();
}

class _CouponSelectPageState extends State<CouponSelectPage> {
  late CouponSelectController controller;
  late JackpotController jackController;
  double couponPrice = 0;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<CouponSelectController>(context, listen: false);
    jackController = Provider.of<JackpotController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final stringCouponPrice = jackController.selectedJackpot!.budgetValue;
      final handledCouponPrice = double.parse(stringCouponPrice);
      controller.setCouponPrice(handledCouponPrice);
      setState(() {
        couponPrice = handledCouponPrice;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const JackBottomNavigationBar(),
        body: Container(
            decoration: const BoxDecoration(color: secondaryColor),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const JackAppBar.transparent(
                      title: null,
                      alignment: MainAxisAlignment.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Responsive.getHeightValue(16),
                          ),
                          Selector<JackpotController, JackpotEntity>(
                              selector: (context, controller) =>
                                  controller.selectedJackpot!,
                              builder: (context, jackpot, child) {
                                return MatchCard(
                                  constraints: constraints,
                                  date: jackpot.matchTime,
                                  homeTeam: jackpot.homeTeam,
                                  visitTeam: jackpot.visitorTeam,
                                  onTap: () {},
                                  potValue: jackpot.potValue,
                                  title: jackpot.championship.name,
                                );
                              }),
                          SizedBox(
                            height: Responsive.getHeightValue(16),
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              JackRoundedButton(
                                  onTap: () {
                                    final questionsController =
                                        Provider.of<JackpotQuestionsController>(
                                            context,
                                            listen: false);
                                    final jackpot =
                                        jackController.selectedJackpot;

                                    questionsController.setIsQuestionsPreview(
                                        true, jackpot!);
                                    Navigator.pushNamed(
                                        context, AppRoutes.jackpotQuestions);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Checar as perguntas deste jackpot',
                                        style: JackFontStyle.body.copyWith(
                                            color: secondaryColor,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.arrow_right_outlined,
                                        color: secondaryColor,
                                      )
                                    ],
                                  )),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: Responsive.getHeightValue(16),
                          ),
                          Selector<CouponSelectController,
                              CouponsBaseQuantity?>(
                            selector: (_, controller) =>
                                controller.couponsBaseQuantity,
                            builder: (_, couponQuantity, __) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    JackSelectableRoundedButton(
                                        height: 44,
                                        withShader: false,
                                        radius: 8,
                                        isSelected:
                                            couponQuantity?.isTree ?? false,
                                        onTap: () =>
                                            controller.setCouponsBaseQuantity(
                                                CouponsBaseQuantity.tree),
                                        label: '3 Cupons'),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    JackRoundedButton.solid(
                                        height: 24,
                                        radius: 10,
                                        onTap: () =>
                                            controller.setCouponsBaseQuantity(
                                                CouponsBaseQuantity.tree),
                                        color: couponQuantity?.isTree ?? false
                                            ? darkBlue.withOpacity(0.5)
                                            : lightGrey,
                                        child: Text(
                                          MoneyFormat.toReal(CouponsBaseQuantity
                                              .tree
                                              .price(couponPrice)
                                              .toString()),
                                          style: JackFontStyle.smallBold
                                              .copyWith(
                                                  color:
                                                      couponQuantity?.isTree ??
                                                              false
                                                          ? darkBlue
                                                          : mediumGrey),
                                        ))
                                  ],
                                ),
                                Column(
                                  children: [
                                    JackSelectableRoundedButton(
                                        height: 44,
                                        withShader: false,
                                        radius: 8,
                                        isSelected:
                                            couponQuantity?.isFive ?? false,
                                        onTap: () =>
                                            controller.setCouponsBaseQuantity(
                                                CouponsBaseQuantity.five),
                                        label: '5 Cupons'),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    JackRoundedButton.solid(
                                        height: 24,
                                        radius: 10,
                                        onTap: () =>
                                            controller.setCouponsBaseQuantity(
                                                CouponsBaseQuantity.five),
                                        color: couponQuantity?.isFive ?? false
                                            ? darkBlue.withOpacity(0.5)
                                            : lightGrey,
                                        child: Text(
                                          MoneyFormat.toReal(CouponsBaseQuantity
                                              .five
                                              .price(couponPrice)
                                              .toString()),
                                          style: JackFontStyle.smallBold
                                              .copyWith(
                                                  color:
                                                      couponQuantity?.isFive ??
                                                              false
                                                          ? darkBlue
                                                          : mediumGrey),
                                        ))
                                  ],
                                ),
                                Column(
                                  children: [
                                    JackSelectableRoundedButton(
                                        height: 44,
                                        withShader: false,
                                        radius: 8,
                                        isSelected:
                                            couponQuantity?.isTen ?? false,
                                        onTap: () =>
                                            controller.setCouponsBaseQuantity(
                                                CouponsBaseQuantity.ten),
                                        label: '10 Cupons'),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    JackRoundedButton.solid(
                                        height: 24,
                                        radius: 10,
                                        onTap: () =>
                                            controller.setCouponsBaseQuantity(
                                                CouponsBaseQuantity.ten),
                                        color: couponQuantity?.isTen ?? false
                                            ? darkBlue.withOpacity(0.3)
                                            : lightGrey,
                                        child: Text(
                                          MoneyFormat.toReal(CouponsBaseQuantity
                                              .ten
                                              .price(couponPrice)
                                              .toString()),
                                          style: JackFontStyle.smallBold
                                              .copyWith(
                                                  color:
                                                      couponQuantity?.isTen ??
                                                              false
                                                          ? darkBlue
                                                          : mediumGrey),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Responsive.getHeightValue(20),
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Selector<CouponSelectController, int>(
                                selector: (_, controller) =>
                                    controller.couponsQuantity,
                                builder: (_, couponQuantity, __) =>
                                    JackSelectableRoundedButton(
                                  height: 44,
                                  withShader:
                                      controller.couponsBaseQuantity == null,
                                  radius: 8,
                                  isSelected: false,
                                  borderColor: mediumGrey,
                                  borderWidth: 2,
                                  onTap: null,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            controller.subtractCoupon(),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 26,
                                          color: mediumGrey,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '$couponQuantity',
                                        style: JackFontStyle.h4Bold.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: mediumGrey),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () => controller.addCoupon(),
                                        child: const Icon(
                                          Icons.add,
                                          size: 26,
                                          color: mediumGrey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Responsive.getHeightValue(20),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: lightGrey,
                                offset: Offset(0, -1),
                                blurRadius: 0.5,
                                spreadRadius: 0.5),
                            BoxShadow(
                                color: lightGrey,
                                offset: Offset(0, -1),
                                blurRadius: 0.9,
                                spreadRadius: 0.9)
                          ],
                          color: secondaryColor),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: secondaryGradient),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Selector<CouponSelectController, int>(
                                  selector: (_, controller) =>
                                      controller.couponsQuantity,
                                  builder: (context, couponsQuantity, child) =>
                                      Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Qtde. Cupons',
                                        style: JackFontStyle.small
                                            .copyWith(color: secondaryColor),
                                      ),
                                      SizedBox(
                                        height: Responsive.getHeightValue(10),
                                      ),
                                      Text(
                                        '$couponsQuantity',
                                        style: JackFontStyle.h3Bold
                                            .copyWith(color: secondaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Selector<CouponSelectController, double>(
                                  selector: (_, controller) =>
                                      controller.totalValue,
                                  builder: (context, totalValue, child) =>
                                      Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Total',
                                        style: JackFontStyle.small
                                            .copyWith(color: secondaryColor),
                                      ),
                                      SizedBox(
                                        height: Responsive.getHeightValue(10),
                                      ),
                                      Text(
                                        MoneyFormat.toReal(
                                            totalValue.toString()),
                                        style: JackFontStyle.h3Bold
                                            .copyWith(color: secondaryColor),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Responsive.getHeightValue(20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              JackSelectableRoundedButton(
                                  height: 44,
                                  withShader: true,
                                  radius: 30,
                                  isSelected: false,
                                  borderColor: darkBlue,
                                  borderWidth: 2,
                                  onTap: () {},
                                  child: Text(
                                    'Adicionar ao carrinho',
                                    style: JackFontStyle.bodyBold
                                        .copyWith(color: secondaryColor),
                                  )),
                              JackSelectableRoundedButton(
                                  height: 44,
                                  withShader: true,
                                  radius: 30,
                                  isSelected: true,
                                  borderColor: darkBlue,
                                  borderWidth: 2,
                                  onTap: () async {
                                    final couponsQuantity =
                                        controller.couponsQuantity;
                                    final questionsController =
                                        Provider.of<JackpotQuestionsController>(
                                            context,
                                            listen: false);
                                    final jackpot =
                                        jackController.selectedJackpot;

                                    questionsController.setIsQuestionsPreview(
                                        false, jackpot!, couponsQuantity);
                                    Navigator.pushNamed(
                                        context, AppRoutes.jackpotQuestions);
                                  },
                                  child: Text(
                                    'Comprar',
                                    style: JackFontStyle.bodyBold
                                        .copyWith(color: secondaryColor),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )),
              ),
            )));
  }
}
