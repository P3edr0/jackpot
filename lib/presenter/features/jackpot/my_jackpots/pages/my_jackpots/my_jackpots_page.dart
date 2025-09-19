import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jackpot/components/appbar/appbar.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/championship_jack_card.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/jackpot/my_jackpots/pages/my_jackpots/store/my_jackpots_controller.dart';
import 'package:jackpot/presenter/features/jackpot/my_jackpots/pages/my_jackpots_details/store/my_jackpots_details_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/shared/utils/enums/bet_filters.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../../../theme/colors.dart';

class MyJackpotsPage extends StatefulWidget {
  const MyJackpotsPage({super.key});

  @override
  State<MyJackpotsPage> createState() => _MyJackpotsPageState();
}

class _MyJackpotsPageState extends State<MyJackpotsPage> {
  late MyJackpotsController controller;
  late JackpotController jackpotController;
  @override
  void initState() {
    super.initState();

    controller = Provider.of<MyJackpotsController>(context, listen: false);
    jackpotController = Provider.of<JackpotController>(context, listen: false);
    final coreController = Provider.of<CoreController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = coreController.user;
      if (user != null) {
        final allJackpots = jackpotController.allCompleteJackpots;
        final allAwards = jackpotController.allAwards;
        await controller.getUserBetMade(user.document!, allJackpots, allAwards);
      }

      if (controller.hasError) {
        await ErrorDialog.show('Erro',
            'Falha ao buscar jackpots.\n Por favor tente mais tarde.', context);
      }
    });
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
              builder: (context, constraints) => SingleChildScrollView(child:
                  Consumer2<MyJackpotsController, CoreController>(builder:
                      (context, myJackpotsController, coreController, child) {
                return myJackpotsController.isLoading
                    ? const Loading()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const JackAppBar(
                              title: 'Meus Jackpots',
                              isTransparent: true,
                              alignment: MainAxisAlignment.start,
                            ),
                            SizedBox(
                              height: Responsive.getHeightValue(10),
                            ),
                            SizedBox(
                              height: Responsive.getHeightValue(16),
                            ),
                            if (!coreController.haveUser)
                              SizedBox(
                                height: constraints.maxHeight -
                                    Responsive.getHeightValue(200),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        height: Responsive.getHeightValue(60),
                                        AppAssets.bagSvg),
                                    SizedBox(
                                        height: Responsive.getHeightValue(16)),
                                    Text(
                                        'Faça o Login\n para ver seus jackpots',
                                        textAlign: TextAlign.center,
                                        style: JackFontStyle.titleBold
                                            .copyWith(color: mediumGrey)),
                                  ],
                                ),
                              ),
                            if (coreController.haveUser &&
                                myJackpotsController.allBetJackpots.isEmpty)
                              SizedBox(
                                height: constraints.maxHeight -
                                    Responsive.getHeightValue(200),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        height: Responsive.getHeightValue(60),
                                        AppAssets.bagSvg),
                                    SizedBox(
                                        height: Responsive.getHeightValue(16)),
                                    Text('Você não possui jackpots',
                                        textAlign: TextAlign.center,
                                        style: JackFontStyle.titleBold
                                            .copyWith(color: mediumGrey)),
                                  ],
                                ),
                              ),
                            if (myJackpotsController.allBetJackpots.isNotEmpty)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      JackSelectableRoundedButton(
                                          isSelected: controller
                                              .betStatusFilter.isActive,
                                          onTap: () =>
                                              controller.setBetStatusFilter(
                                                  BetFilters.active),
                                          label: 'Ativos'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      JackSelectableRoundedButton(
                                          isSelected: controller
                                              .betStatusFilter.isClosed,
                                          onTap: () =>
                                              controller.setBetStatusFilter(
                                                  BetFilters.closed),
                                          label: 'Encerrados'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      JackSelectableRoundedButton(
                                          isSelected: controller
                                              .betStatusFilter.isAwarded,
                                          onTap: () =>
                                              controller.setBetStatusFilter(
                                                  BetFilters.awarded),
                                          label: 'Premiados'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Responsive.getHeightValue(16),
                                  ),
                                  if (coreController.haveUser &&
                                      myJackpotsController.betJackpots.isEmpty)
                                    SizedBox(
                                      height: constraints.maxHeight -
                                          Responsive.getHeightValue(200),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              height:
                                                  Responsive.getHeightValue(60),
                                              AppAssets.bagSvg),
                                          SizedBox(
                                              height: Responsive.getHeightValue(
                                                  16)),
                                          Text('Vazio',
                                              textAlign: TextAlign.center,
                                              style: JackFontStyle.titleBold
                                                  .copyWith(color: mediumGrey)),
                                        ],
                                      ),
                                    ),
                                  Column(
                                    children: myJackpotsController.betJackpots
                                        .map((jack) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16),
                                            child: ChampionshipJackCard(
                                              onTap: () async {
                                                // final selectedTempBets =
                                                //     controller
                                                //         .getSelectedTempBets(
                                                //             jack.id);
                                                final detailsController = Provider
                                                    .of<MyJackpotsDetailsController>(
                                                        context,
                                                        listen: false);
                                                final userBets = controller
                                                    .getUserSelectedJackpotBets(
                                                        jack);

                                                // detailsController
                                                //     .setSelectedTempBets(
                                                //         selectedTempBets);
                                                detailsController
                                                    .setSelectedBetJackpot(
                                                        jack);
                                                detailsController
                                                    .setSelectedBets(userBets);
                                                Navigator.pushNamed(
                                                    context,
                                                    AppRoutes
                                                        .myJackpotsDetails);
                                              },
                                              title: jack.championship.name,
                                              constraints: constraints,
                                              image: jack.banner,
                                              date: jack.matchTime,
                                              homeTeam: jack.homeTeam,
                                              visitTeam: jack.visitorTeam,
                                              isFavorite: true,
                                              setFavorite: () {},
                                            )))
                                        .toList(),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
              })),
            ),
          ),
        ));
  }
}
