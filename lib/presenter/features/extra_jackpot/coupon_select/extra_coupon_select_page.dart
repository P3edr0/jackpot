import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jackpot/components/appbar/appbar_secondary.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/buy_resume_card.dart';
import 'package:jackpot/components/loadings/loading_content.dart';
import 'package:jackpot/components/shopping_cart_item.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/extra_jackpot/coupon_select/store/extra_coupon_select_controller.dart';
import 'package:jackpot/presenter/features/extra_jackpot/extra_jackpot_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/payment/pages/components/logged_user_content.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/presenter/features/shopping_cart/store/shopping_cart_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/shared/utils/enums/coupons_base_quantity.dart';
import 'package:jackpot/shared/utils/formatters/money_formatters.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../theme/colors.dart';

class ExtraCouponSelectPage extends StatefulWidget {
  const ExtraCouponSelectPage({super.key});

  @override
  State<ExtraCouponSelectPage> createState() => _ExtraCouponSelectPageState();
}

class _ExtraCouponSelectPageState extends State<ExtraCouponSelectPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

  OverlayEntry? _overlayEntry;
  bool _isAnimating = false;

  late ExtraCouponSelectController controller;
  late ExtraJackpotController extraJackController;
  double couponPrice = 0;

  @override
  void initState() {
    super.initState();
    controller =
        Provider.of<ExtraCouponSelectController>(context, listen: false);
    extraJackController =
        Provider.of<ExtraJackpotController>(context, listen: false);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _isAnimating = false;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cartela adicionada ao carrinho!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final stringCouponPrice =
          extraJackController.selectedJackpot?.first.potValue;
      final handledCouponPrice = double.parse(stringCouponPrice!);
      controller.setCouponPrice(handledCouponPrice);
      setState(() {
        couponPrice = handledCouponPrice;
      });
    });
  }

  void _addToCart(Offset startPosition, String image) {
    final bytes = base64Decode(image);
    if (_isAnimating) return;
    _isAnimating = true;

    setState(() {
      _positionAnimation = Tween<Offset>(
        begin: startPosition,
        end: Offset(MediaQuery.of(context).size.width, -100),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ));

      _sizeAnimation = Tween<double>(begin: 1.0, end: 0.3).animate(_controller);
      _opacityAnimation =
          Tween<double>(begin: 1.0, end: 0.5).animate(_controller);
    });

    _overlayEntry = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Positioned(
            left: _positionAnimation.value.dx - 30,
            top: _positionAnimation.value.dy - 30,
            child: Transform.scale(
              scale: _sizeAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Image.memory(
                    bytes,
                    width: 80,
                    height: 80,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      width: 80,
                      height: 80,
                      AppAssets.splash,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _controller.reset();
    _controller.forward();
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
                    Consumer<ShoppingCartController>(
                        builder: (context, shoppingCartController, child) =>
                            JackAppBarSecondary(
                                isTransparent: false,
                                alignment: MainAxisAlignment.start,
                                child: Expanded(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                      JackCartIcon(
                                        itemCount:
                                            shoppingCartController.totalCoupons,
                                        onTap: () async => Navigator.pushNamed(
                                            context, AppRoutes.shoppingCart),
                                      ),
                                    ])))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Responsive.getHeightValue(16),
                          ),
                          Selector<ExtraJackpotController, String>(
                              selector: (context, controller) =>
                                  controller.selectedJackpotImage,
                              builder: (context, jackpot, child) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: SizedBox(
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Image.network(jackpot,
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
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
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                      AppAssets.splash,
                                                      fit: BoxFit.cover,
                                                    )),
                                          ),
                                        ],
                                      ),
                                    ));
                              }),
                          SizedBox(
                            height: Responsive.getHeightValue(32),
                          ),
                          Selector<ExtraCouponSelectController,
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
                              Selector<ExtraCouponSelectController, int>(
                                selector: (_, controller) =>
                                    controller.couponsQuantity,
                                builder: (_, couponQuantity, __) =>
                                    JackSelectableRoundedButton(
                                  height: 44,
                                  padding: 0,
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
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Icon(
                                            Icons.remove,
                                            size: 26,
                                            color: mediumGrey,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '$couponQuantity',
                                        style: JackFontStyle.h4Bold.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: mediumGrey),
                                      ),
                                      InkWell(
                                        onTap: () => controller.addCoupon(),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Icon(
                                            Icons.add,
                                            size: 26,
                                            color: mediumGrey,
                                          ),
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
                          Consumer<ExtraCouponSelectController>(
                              builder: (context, controller, child) =>
                                  BuyResumeCard(
                                    couponsQuantity: controller.couponsQuantity,
                                    totalValue: controller.totalValue,
                                  )),
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
                                  onTap: () {
                                    final jackpot =
                                        extraJackController.selectedJackpot!;
                                    final couponsQuantity =
                                        controller.couponsQuantity;
                                    final couponsPrice = controller.couponPrice;
                                    final image = extraJackController
                                        .selectedJackpot!.first.banner;
                                    coreController =
                                        Provider.of<CoreController>(context,
                                            listen: false);
                                    _addToCart(
                                        Offset(
                                          MediaQuery.of(context).size.width / 2,
                                          MediaQuery.of(context).size.height /
                                              2,
                                        ),
                                        image);
                                    // coreController.addShoppingCartItem(
                                    //     jackpot.first,
                                    //     couponsQuantity,
                                    //     couponsPrice);
                                  },
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
                                    final totalValue = controller.totalValue;

                                    final paymentController =
                                        Provider.of<PaymentController>(context,
                                            listen: false);

//TODO:IMPLEMENTAR FUNÇÂO
                                    // paymentController.setPaymentData(
                                    //     newCouponsQuantity: couponsQuantity,
                                    //     newTotalValue: totalValue);
                                    // final jackpot =
                                    //     extraJackController.selectedJackpot;
                                    // final mockJackpot = JackpotEntity(
                                    //     id: extraJackController
                                    //         .selectedJackpotId,
                                    //     betId: extraJackController
                                    //         .selectedJackpotId,
                                    //     championship:
                                    //         ResumeChampionshipEntity.empty(''),
                                    //     banner: extraJackController
                                    //         .selectedJackpotImage,
                                    //     potValue: '10000',
                                    //     endAt: DateTime.now(),
                                    //     matchTime: DateTime.now(),
                                    //     budgetValue: '11500',
                                    //     awardsId: [],
                                    //     description: 'Vazio',
                                    //     questionId: '',
                                    //     homeTeam: TeamEntity.empty('0'),
                                    //     visitorTeam: TeamEntity.empty('0'),
                                    //     jackpotOwnerTeam: TeamEntity.empty('0'),
                                    //     questions: QuestionEntity(
                                    //         id: '',
                                    //         title: '',
                                    //         category: '',
                                    //         createAt: null,
                                    //         items: []));
                                    // extraJackController
                                    //     .setSelectedJackpot([mockJackpot]);

                                    Navigator.pushNamed(
                                        context, AppRoutes.payment);
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
