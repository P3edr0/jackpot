import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jackpot/components/appbar/appbar_secondary.dart';
import 'package:jackpot/components/buttons/outline_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/small_item_shopping_card.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/domain/entities/shopping_cart_jackpot_entity.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/store/jackpot_questions_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/presenter/features/shopping_cart/store/shopping_cart_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/shared/utils/formatters/money_formatters.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../theme/colors.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late ShoppingCartController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<ShoppingCartController>(context, listen: false);
    final jackpotController =
        Provider.of<JackpotController>(context, listen: false);
    List<AwardEntity> awards = jackpotController.allAwards;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (awards.isEmpty) {
        await jackpotController.getAllAwards();
        awards = jackpotController.allAwards;
      }
      controller.updateItemsAwards(awards);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Selector<ShoppingCartController, bool>(
            selector: (_, controller) => controller.loading,
            builder: (context, loading, child) =>
                loading ? const SizedBox() : const JackBottomNavigationBar()),
        body: Selector<ShoppingCartController, bool>(
          selector: (_, controller) => controller.loading,
          builder: (context, loading, child) => loading
              ? const Loading()
              : Container(
                  decoration: const BoxDecoration(gradient: primaryGradient),
                  child: SafeArea(
                    child: LayoutBuilder(
                      builder: (context, constraints) => SingleChildScrollView(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          JackAppBarSecondary(
                              alignment: MainAxisAlignment.start,
                              child: SizedBox(
                                width: constraints.maxWidth - 95,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Meu carrinho',
                                      style: JackFontStyle.bodyLargeBold
                                          .copyWith(color: secondaryColor),
                                    ),
                                    const Spacer(),
                                    JackOutlineButton(
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              AppAssets.shoppingCartSvg,
                                              semanticsLabel: 'Shopping Cart',
                                              height:
                                                  Responsive.getHeightValue(16),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Consumer<ShoppingCartController>(
                                              builder: (context, controller,
                                                      child) =>
                                                  Text(
                                                '${controller.totalCoupons} | ${MoneyFormat.toReal(controller.totalPrice.toString())}',
                                                style: JackFontStyle
                                                    .bodyLargeBold
                                                    .copyWith(
                                                        color: secondaryColor),
                                              ),
                                            )
                                          ],
                                        ),
                                        onTap: () {}),
                                  ],
                                ),
                              )),
                          Container(
                            decoration: const BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Responsive.getHeightValue(16),
                                ),
                                Selector<ShoppingCartController,
                                        List<JackpotAggregateEntity>>(
                                    selector: (context, controller) =>
                                        controller.cartItems,
                                    builder: (context, jackpots, child) {
                                      if (jackpots.isEmpty) {
                                        return Center(
                                          heightFactor: 8,
                                          child: Text('Lista Vazia',
                                              style: JackFontStyle.title
                                                  .copyWith(color: darkBlue)),
                                        );
                                      }
                                      return Column(
                                        children: jackpots
                                            .map((jack) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16),
                                                child: SmallItemShoppingCard(
                                                  onTap: () {
                                                    final handledSportsJack =
                                                        jack.jackpot;
                                                    final paymentController =
                                                        Provider.of<
                                                                PaymentController>(
                                                            context,
                                                            listen: false);
                                                    final jackController = Provider
                                                        .of<JackpotController>(
                                                            context,
                                                            listen: false);
                                                    final questionsController =
                                                        Provider.of<
                                                                JackpotQuestionsController>(
                                                            context,
                                                            listen: false);
                                                    jackController
                                                        .setSelectedJackpot(
                                                            [jack.jackpot]);
                                                    final jackTotalPrice = jack
                                                            .couponPrice *
                                                        jack.couponsQuantity;
                                                    paymentController.setPaymentData(
                                                        newCouponsQuantity: jack
                                                            .couponsQuantity,
                                                        newPaymentCouponsQuantity:
                                                            jack
                                                                .couponsQuantity,
                                                        newTotalValue:
                                                            jackTotalPrice,
                                                        newUnitValue:
                                                            jack.couponPrice,
                                                        newItemPaymentDescription:
                                                            "JACKPOT ${handledSportsJack.jackpotOwnerTeam.name} - ID ${handledSportsJack.id}",
                                                        newItemDescription:
                                                            "JACKPOT ${handledSportsJack.jackpotOwnerTeam.name}");

                                                    final newTemporaryBet =
                                                        TemporaryBetEntity(
                                                            couponQuantity: jack
                                                                .couponsQuantity,
                                                            jackpotId:
                                                                jack.jackpot.id,
                                                            couponPrice: jack
                                                                .couponPrice);

                                                    jackController
                                                        .setTemporaryBets(
                                                            [newTemporaryBet]);
                                                    questionsController
                                                        .startJackpotStructure(
                                                            newJackpots: [jack],
                                                            betAnswers: []);
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.payment);
                                                  },
                                                  title: '',
                                                  constraints: constraints,
                                                  image: jack.jackpot.banner,
                                                  couponsQuantity: jack
                                                      .couponsQuantity
                                                      .toString(),
                                                  onTapRemove: () => controller
                                                      .removeItem(jack),
                                                )))
                                            .toList(),
                                      );
                                    }),
                                SizedBox(
                                  height: Responsive.getHeightValue(16),
                                ),
                                InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRoutes.home),
                                    child: Text(
                                      '+ Adicionar ao carrinho',
                                      style: JackFontStyle.bodyLargeBold
                                          .copyWith(color: darkBlue),
                                    )),
                                SizedBox(
                                  height: Responsive.getHeightValue(16),
                                ),
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
                                          final jacks = controller.cartItems
                                              .map((item) => item.jackpot)
                                              .toList();
                                          final paymentController =
                                              Provider.of<PaymentController>(
                                                  context,
                                                  listen: false);
                                          final jackController =
                                              Provider.of<JackpotController>(
                                                  context,
                                                  listen: false);
                                          final questionsController = Provider
                                              .of<JackpotQuestionsController>(
                                                  context,
                                                  listen: false);
                                          jackController
                                              .setSelectedJackpot(jacks);
                                          final allIds = jacks
                                              .map((element) => element.id)
                                              .toList();
                                          String paymentDescription = '';
                                          String itemDescription = '';
                                          if (allIds.length > 1) {
                                            paymentDescription =
                                                "MÚLTIPLOS JACKPOTS - IDS $allIds";
                                            itemDescription =
                                                "MÚLTIPLOS JACKPOTS";
                                          } else {
                                            paymentDescription =
                                                "JACKPOT ${jacks.first.jackpotOwnerTeam.name} - ID ${jacks.first.id}";
                                            itemDescription =
                                                "JACKPOT ${jacks.first.jackpotOwnerTeam.name} ";
                                          }

                                          final newTemporaryBets = controller
                                              .cartItems
                                              .map((element) =>
                                                  TemporaryBetEntity(
                                                      couponQuantity: element
                                                          .couponsQuantity,
                                                      jackpotId:
                                                          element.jackpot.id,
                                                      couponPrice:
                                                          element.couponPrice))
                                              .toList();

                                          jackController.setTemporaryBets(
                                              newTemporaryBets);
                                          paymentController.setPaymentData(
                                              newCouponsQuantity:
                                                  controller.totalCoupons,
                                              newTotalValue:
                                                  controller.totalPrice,
                                              newPaymentCouponsQuantity: 1,
                                              newUnitValue:
                                                  controller.totalPrice,
                                              newItemPaymentDescription:
                                                  paymentDescription,
                                              newItemDescription:
                                                  itemDescription);

                                          questionsController
                                              .startJackpotStructure(
                                                  newJackpots:
                                                      controller.cartItems,
                                                  betAnswers: []);

                                          Navigator.pushNamed(
                                              context, AppRoutes.payment);
                                        },
                                        child: Text(
                                          'Finalizar Compra',
                                          style: JackFontStyle.bodyLargeBold
                                              .copyWith(color: secondaryColor),
                                        )),
                                    const Spacer()
                                  ],
                                ),
                                SizedBox(
                                  height: Responsive.getHeightValue(16),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                    ),
                  )),
        ));
  }
}
