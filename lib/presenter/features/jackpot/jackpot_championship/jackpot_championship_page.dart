import 'package:flutter/material.dart';
import 'package:jackpot/components/appbar/appbar_secondary.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/banner_card.dart';
import 'package:jackpot/components/cards/championship_jack_card.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/components/shopping_cart_item.dart';
import 'package:jackpot/components/textfields/textfield.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_championship/store/jackpot_championship_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/presenter/features/shopping_cart/store/shopping_cart_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/jack_filters_type.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class JackpotChampionshipPage extends StatefulWidget {
  const JackpotChampionshipPage({super.key});

  @override
  State<JackpotChampionshipPage> createState() =>
      _JackpotChampionshipPageState();
}

class _JackpotChampionshipPageState extends State<JackpotChampionshipPage> {
  late JackpotChampionshipController controller;
  late JackpotController jackpotController;
  @override
  void initState() {
    super.initState();

    jackpotController = Provider.of<JackpotController>(context, listen: false);
    controller =
        Provider.of<JackpotChampionshipController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getChampionshipPreviewJackpots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Selector<JackpotChampionshipController, bool>(
            selector: (context, controller) => controller.isLoading,
            builder: (context, isLoading, child) =>
                isLoading ? const SizedBox() : const JackBottomNavigationBar()),
        body: Container(
          decoration: const BoxDecoration(color: secondaryColor),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                  child: Selector<JackpotChampionshipController, bool>(
                      selector: (context, controller) => controller.isLoading,
                      builder: (context, isLoading, child) {
                        return isLoading
                            ? const Loading()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: Responsive.getHeightValue(
                                                  270),
                                            ),
                                            Consumer<
                                                JackpotChampionshipController>(
                                              builder: (context, controller,
                                                      child) =>
                                                  Row(
                                                      children: controller
                                                          .filterTeams
                                                          .map((team) {
                                                final bool isSelected = team
                                                        .id ==
                                                    controller
                                                        .selectedFilterTeamId;
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: InkWell(
                                                      onTap: () => controller
                                                          .setTeamFilter(
                                                              team.id),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Container(
                                                          height: Responsive
                                                              .getHeightValue(
                                                                  66),
                                                          width: Responsive
                                                              .getHeightValue(
                                                                  66),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color: isSelected
                                                                  ? darkBlue
                                                                  : lightGrey),
                                                          child: Image.network(
                                                            team.logo,
                                                            height: Responsive
                                                                .getHeightValue(
                                                                    40),
                                                          ),
                                                        ),
                                                      )),
                                                );
                                              }).toList()),
                                            ),
                                            SizedBox(
                                              height:
                                                  Responsive.getHeightValue(16),
                                            ),
                                            JackTextfield(
                                              controller:
                                                  controller.searchController,
                                              hint:
                                                  "Pesquise seu time do coração",
                                              radius: 30,
                                              prefix: const Icon(Icons.search),
                                              onChanged: (value) =>
                                                  controller.searchFilter(),
                                            ),
                                            SizedBox(
                                              height:
                                                  Responsive.getHeightValue(16),
                                            ),
                                            Selector<
                                                JackpotChampionshipController,
                                                JackFiltersType>(
                                              selector: (_, controller) =>
                                                  controller.jackFiltersType,
                                              builder: (_, filter, __) => Row(
                                                children: [
                                                  JackSelectableRoundedButton(
                                                      isSelected: filter.isAll,
                                                      onTap: () => controller
                                                          .setJackFiltersType(
                                                              JackFiltersType
                                                                  .all),
                                                      label: 'Todos'),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  JackSelectableRoundedButton(
                                                      isSelected: filter.isPots,
                                                      onTap: () => controller
                                                          .setJackFiltersType(
                                                              JackFiltersType
                                                                  .pots),
                                                      label: 'Potes'),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  JackSelectableRoundedButton(
                                                      isSelected:
                                                          filter.isAwards,
                                                      onTap: () => controller
                                                          .setJackFiltersType(
                                                              JackFiltersType
                                                                  .awards),
                                                      label: 'Prêmios'),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  Responsive.getHeightValue(16),
                                            ),
                                            Selector<
                                                    JackpotChampionshipController,
                                                    List<JackpotEntity>>(
                                                selector: (context,
                                                        controller) =>
                                                    controller
                                                        .championshipCompleteJackpots,
                                                builder:
                                                    (context, jackpots, child) {
                                                  if (jackpots.isEmpty) {
                                                    return Center(
                                                      heightFactor: 8,
                                                      child: Text('Lista Vazia',
                                                          style: JackFontStyle
                                                              .title
                                                              .copyWith(
                                                                  color:
                                                                      darkBlue)),
                                                    );
                                                  }
                                                  return Column(
                                                    children: jackpots
                                                        .map((jack) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 16),
                                                            child:
                                                                ChampionshipJackCard(
                                                              onTap: () {
                                                                final jackController =
                                                                    Provider.of<
                                                                            JackpotController>(
                                                                        context,
                                                                        listen:
                                                                            false);
                                                                jackController
                                                                    .setSelectedJackpot(
                                                                        [jack]);
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    AppRoutes
                                                                        .couponSelect);
                                                              },
                                                              title: jack
                                                                  .championship
                                                                  .name,
                                                              constraints:
                                                                  constraints,
                                                              image:
                                                                  jack.banner,
                                                              date: jack
                                                                  .matchTime,
                                                              homeTeam:
                                                                  jack.homeTeam,
                                                              visitTeam: jack
                                                                  .visitorTeam,
                                                              isFavorite: true,
                                                              setFavorite:
                                                                  () {},
                                                            )))
                                                        .toList(),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        child: Container(
                                            alignment: Alignment.topCenter,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Responsive.getHeightValue(
                                                        3)),
                                            decoration: const BoxDecoration(
                                                gradient: secondaryGradient,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20))),
                                            width: constraints.maxWidth,
                                            height:
                                                Responsive.getHeightValue(180),
                                            child: Consumer2<
                                                    JackpotChampionshipController,
                                                    ShoppingCartController>(
                                                builder: (context,
                                                        jackpotChampionshipController,
                                                        shoppingCartController,
                                                        child) =>
                                                    JackAppBarSecondary(
                                                        isTransparent: true,
                                                        alignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        child: Expanded(
                                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                          Text(
                                                            jackpotChampionshipController
                                                                .selectedChampionshipName,
                                                            style: JackFontStyle
                                                                .title
                                                                .copyWith(
                                                                    color:
                                                                        secondaryColor),
                                                          ),
                                                          JackCartIcon(
                                                            itemCount:
                                                                shoppingCartController
                                                                    .totalCoupons,
                                                            onTap: () async =>
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    AppRoutes
                                                                        .shoppingCart),
                                                          ),
                                                        ]))))),
                                      ),
                                      Positioned(
                                          top: Responsive.getHeightValue(100),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Selector<
                                                  JackpotChampionshipController,
                                                  String>(
                                                selector: (context,
                                                        controller) =>
                                                    controller
                                                        .selectedChampionshipBanner,
                                                builder:
                                                    (context, banner, child) =>
                                                        BannerCard(
                                                  image: banner,
                                                ),
                                              ))),
                                    ],
                                  ),
                                ],
                              );
                      })),
            ),
          ),
        ));
  }
}
