import 'package:flutter/material.dart';
import 'package:jackpot/components/appbar/appbar.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/match_card.dart';
import 'package:jackpot/components/dialogs/confirm_dialog.dart';
import 'package:jackpot/components/dialogs/info_dialog.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/jackpot/coupon_select/store/coupon_select_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/components/question_card.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/store/jackpot_questions_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/coupons_base_quantity.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../theme/colors.dart';

class JackpotQuestionsPage extends StatefulWidget {
  const JackpotQuestionsPage({super.key});

  @override
  State<JackpotQuestionsPage> createState() => _JackpotQuestionsPageState();
}

class _JackpotQuestionsPageState extends State<JackpotQuestionsPage> {
  late JackpotQuestionsController controller;
  late JackpotController jackController;
  final GlobalKey _targetKey = GlobalKey();
  @override
  void initState() {
    super.initState();

    controller =
        Provider.of<JackpotQuestionsController>(context, listen: false);
    jackController = Provider.of<JackpotController>(context, listen: false);
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Responsive.getHeightValue(16),
                                        key: _targetKey,
                                      ),
                                      Selector<JackpotController,
                                              JackpotEntity>(
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
                                      Consumer<JackpotQuestionsController>(
                                        builder: (context, value, child) => Row(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () => controller
                                                          .backQuestionPage(),
                                                      child: Icon(
                                                        Icons.arrow_left,
                                                        size: 28,
                                                        color: controller
                                                                .canBackQuestionPage
                                                            ? primaryColor
                                                            : lightGrey,
                                                      ),
                                                    ),
                                                    Text(
                                                      'CARD ${controller.currentQuestionPage}/${controller.couponsQuantity}',
                                                      style: JackFontStyle.body
                                                          .copyWith(
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        if (controller
                                                            .canSkipQuestionPage) {
                                                          controller
                                                              .skipQuestionPage();

                                                          WidgetsBinding
                                                              .instance
                                                              .addPostFrameCallback(
                                                                  (_) {
                                                            if (_targetKey
                                                                    .currentContext !=
                                                                null) {
                                                              Scrollable
                                                                  .ensureVisible(
                                                                _targetKey
                                                                    .currentContext!,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            300),
                                                                curve: Curves
                                                                    .easeInOut,
                                                              );
                                                            }
                                                          });
                                                        } else {
                                                          InfoDialog.closeAuto(
                                                              'Atenção',
                                                              'Preencha todos os campos para prosseguir',
                                                              context);
                                                        }
                                                      },
                                                      child: Icon(
                                                        Icons.arrow_right,
                                                        size: 28,
                                                        color: controller
                                                                .canSkipQuestionPage
                                                            ? primaryColor
                                                            : lightGrey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 10),
                                                const Icon(
                                                  Icons.arrow_right_outlined,
                                                  color: secondaryColor,
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: primaryColor
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                'Faltam ${controller.remainQuestions} cards',
                                                style: JackFontStyle.body
                                                    .copyWith(
                                                        color: primaryColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Responsive.getHeightValue(20),
                                ),
                                Consumer<JackpotQuestionsController>(
                                    builder: (context, controller, child) {
                                  final jackpot = controller.selectedJackpot!;
                                  final questions = jackpot.questions.items;
                                  return ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 10,
                                          ),
                                      itemCount: questions.length,
                                      itemBuilder: (context, index) {
                                        final question =
                                            questions[index].question;
                                        final isObjective = questions[index]
                                            .questionType
                                            .isObjective;
                                        final isSingle = questions[index]
                                            .questionQuantity
                                            .isSingle;
                                        final level = questions[index].potLevel;
                                        final bool isPreview =
                                            controller.isQuestionsPreview;
                                        final auxContent = questions[index]
                                            .subjDoubleValue
                                            .replaceAll(',', ' ');
                                        List<String> options = [];
                                        if (isObjective) {
                                          options = questions[index].objOptions;
                                        }
                                        final questionStructure = controller
                                            .questionsStructure[index];
                                        if (question.trim().isEmpty) {
                                          return const SizedBox();
                                        }

                                        return QuestionCard(
                                          level: level,
                                          question: question,
                                          isObjective: isObjective,
                                          options: options,
                                          isSingle: isSingle,
                                          auxContent: auxContent,
                                          constraints: constraints,
                                          questionStructure: questionStructure,
                                          questionIndex: index,
                                          isPreview: isPreview,
                                        );
                                      });
                                }),
                                SizedBox(
                                  height: Responsive.getHeightValue(10),
                                ),
                                if (!controller.isQuestionsPreview)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Responsive.getHeightValue(24)),
                                    child: Column(
                                      children: [
                                        Selector<JackpotQuestionsController,
                                            bool>(
                                          selector: (_, controller) =>
                                              controller.isLastPage,
                                          builder:
                                              (context, isLastPage, child) =>
                                                  Visibility(
                                            maintainState: true,
                                            visible: isLastPage,
                                            child: Container(
                                                width: constraints.maxWidth,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: lightGrey),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.info,
                                                          color: mediumGrey,
                                                          size: 20,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            ('Regras e Termos'),
                                                            style: JackFontStyle
                                                                .bodyLarge
                                                                .copyWith(
                                                                    color:
                                                                        mediumGrey)),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    SizedBox(
                                                      height: Responsive
                                                          .getHeightValue(200),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Text(
                                                          (lorem),
                                                          style: JackFontStyle
                                                              .bodyLarge
                                                              .copyWith(
                                                                  color:
                                                                      mediumGrey),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Responsive
                                                          .getHeightValue(10),
                                                    ),
                                                    Selector<
                                                        JackpotQuestionsController,
                                                        bool>(
                                                      selector:
                                                          (_, controller) =>
                                                              controller
                                                                  .acceptTerms,
                                                      builder: (context,
                                                              isSelected,
                                                              child) =>
                                                          InkWell(
                                                        onTap: () {
                                                          final controller =
                                                              Provider.of<
                                                                      JackpotQuestionsController>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          controller
                                                              .setAcceptTerms();
                                                        },
                                                        child: Row(
                                                          children: [
                                                            isSelected
                                                                ? const Icon(
                                                                    Icons
                                                                        .check_box,
                                                                    color:
                                                                        primaryColor,
                                                                    size: 26,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .check_box_outline_blank,
                                                                    color:
                                                                        primaryColor,
                                                                    size: 26,
                                                                  ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                                ('Aceito os Termos e Condições'),
                                                                style: JackFontStyle
                                                                    .bodyLargeBold
                                                                    .copyWith(
                                                                        color:
                                                                            primaryColor)),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Responsive.getHeightValue(16),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:
                                                  JackSelectableRoundedButton(
                                                      height: 44,
                                                      withShader: true,
                                                      radius: 30,
                                                      isSelected: false,
                                                      borderColor: darkBlue,
                                                      borderWidth: 2,
                                                      onTap: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: Text(
                                                        'Cancelar',
                                                        style: JackFontStyle
                                                            .bodyBold
                                                            .copyWith(
                                                                color:
                                                                    secondaryColor),
                                                      )),
                                            ),
                                            SizedBox(
                                              width:
                                                  Responsive.getHeightValue(20),
                                            ),
                                            Expanded(
                                              child: Selector<
                                                      JackpotQuestionsController,
                                                      bool>(
                                                  selector: (_, controller) =>
                                                      controller.isLastPage,
                                                  builder: (context, isLastPage,
                                                          child) =>
                                                      JackSelectableRoundedButton(
                                                          height: 44,
                                                          withShader: true,
                                                          radius: 30,
                                                          isSelected: true,
                                                          borderColor: darkBlue,
                                                          borderWidth: 2,
                                                          onTap: () async {
                                                            if (!controller
                                                                .isLastPage) {
                                                              if (!controller
                                                                  .canSkipQuestionPage) {
                                                                InfoDialog.closeAuto(
                                                                    'Atenção',
                                                                    'Preencha todos os campos para prosseguir',
                                                                    context);
                                                                return;
                                                              }
                                                              controller
                                                                  .skipQuestionPage();

                                                              if (_targetKey
                                                                      .currentContext !=
                                                                  null) {
                                                                Scrollable
                                                                    .ensureVisible(
                                                                  _targetKey
                                                                      .currentContext!,
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  curve: Curves
                                                                      .easeInOut,
                                                                );
                                                              }

                                                              return;
                                                            }
                                                            if (!controller
                                                                .acceptTerms) {
                                                              InfoDialog.closeAuto(
                                                                  'Atenção',
                                                                  'Aceite os termos e condições para prosseguir',
                                                                  context);
                                                              return;
                                                            }

                                                            await ConfirmDialog
                                                                .show(
                                                                    '',
                                                                    "Estas respostas não poderão mais ser alteradas após confirmar.",
                                                                    context,
                                                                    () {
                                                              controller
                                                                  .clearFields();
                                                              final couponController =
                                                                  Provider.of<
                                                                          CouponSelectController>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              couponController
                                                                  .setCouponsBaseQuantity(
                                                                      CouponsBaseQuantity
                                                                          .five);

                                                              Navigator
                                                                  .pushNamed(
                                                                      context,
                                                                      AppRoutes
                                                                          .home);
                                                            });
                                                          },
                                                          child: Text(
                                                            isLastPage
                                                                ? 'Salvar'
                                                                : 'Próximo',
                                                            style: JackFontStyle
                                                                .bodyBold
                                                                .copyWith(
                                                                    color:
                                                                        secondaryColor),
                                                          ))),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(
                                  height: Responsive.getHeightValue(20),
                                ),
                              ]),
                        )))));
  }

  String lorem =
      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.';
}
