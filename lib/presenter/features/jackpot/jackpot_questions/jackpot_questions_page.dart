import 'package:flutter/material.dart';
import 'package:jackpot/components/appbar/appbar.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/match_card.dart';
import 'package:jackpot/components/dialogs/confirm_dialog.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/dialogs/info_dialog.dart';
import 'package:jackpot/components/dialogs/quit_questions_dialog.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/domain/entities/question_collection_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/presenter/features/jackpot/coupon_select/store/coupon_select_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/components/question_card.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/store/jackpot_questions_controller.dart';
import 'package:jackpot/presenter/features/jackpot/my_jackpots/pages/my_jackpots/store/my_jackpots_controller.dart';
import 'package:jackpot/presenter/features/jackpot/my_jackpots/pages/my_jackpots_details/store/my_jackpots_details_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/bet_status.dart';
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
  late CoreController coreController;
  final GlobalKey _targetKey = GlobalKey();
  @override
  void initState() {
    super.initState();

    controller =
        Provider.of<JackpotQuestionsController>(context, listen: false);
    jackController = Provider.of<JackpotController>(context, listen: false);
    coreController = Provider.of<CoreController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (!controller.isQuestionsPreview && coreController.haveUser) {
          jackController.setTemporaryBetContent(
              BetStatus.waitingAnswer, coreController.user!.document!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) {
            return;
          }
          final bool isPreview = controller.isQuestionsPreview;
          if (isPreview) {
            Navigator.pop(context);
            return;
          }
          bool shouldPop = await QuitQuestionsDialog.show(
              'Sair das perguntas?',
              "Você perderá seu progresso, mas poderá responder o Jackpot antes que ele expire na aba \"Meus Jackpots\".",
              context);
          if (shouldPop && context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.home, ModalRoute.withName(AppRoutes.login));
          }
        },
        child: Container(
          decoration: const BoxDecoration(color: secondaryColor),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: Selector<JackpotQuestionsController, bool>(
                  selector: (_, controller) => controller.isLoading,
                  builder: (context, isLoading, child) => Column(
                    children: [
                      Visibility(
                          maintainState: true,
                          visible: isLoading,
                          child: const Loading()),
                      Visibility(
                        maintainState: true,
                        visible: !isLoading,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (controller.isQuestionsPreview)
                                const JackAppBar.transparent(
                                  title: '',
                                ),
                              SizedBox(
                                height: Responsive.getHeightValue(20),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: Responsive.getHeightValue(16),
                                      key: _targetKey,
                                    ),
                                    Selector<JackpotController,
                                            SportJackpotEntity>(
                                        selector: (context, controller) =>
                                            controller.selectedJackpot!.first
                                                as SportJackpotEntity,
                                        builder: (context, jackpot, child) {
                                          return MatchCard(
                                            constraints: constraints,
                                            date: jackpot.matchTime,
                                            homeTeam: jackpot.homeTeam,
                                            visitTeam: jackpot.visitorTeam,
                                            onTap: () {},
                                            potValue: jackpot.potValue!,
                                            title: jackpot.championship.name,
                                          );
                                        }),
                                    Selector<JackpotQuestionsController, bool>(
                                        selector: (context, controller) =>
                                            controller.hasMultipleBets,
                                        builder: (context, jackpot, child) {
                                          if (controller.hasMultipleBets) {
                                            return Text(
                                              'JOGO 1/${controller.betQueue.length}',
                                              style: JackFontStyle.body
                                                  .copyWith(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w900),
                                            );
                                          }
                                          return const SizedBox();
                                        }),
                                    SizedBox(
                                      height: Responsive.getHeightValue(16),
                                    ),
                                    Consumer<JackpotQuestionsController>(
                                      builder: (context, value, child) => Row(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () => controller
                                                        .backQuestionPage(),
                                                    child: Icon(
                                                      Icons.arrow_left,
                                                      size: 50,
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
                                                            color: primaryColor,
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

                                                        WidgetsBinding.instance
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
                                                      size: 50,
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: primaryColor
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
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
                                Map<int, List<QuestionCollectionEntity>>
                                    collections = {};
                                for (int index = 0;
                                    index < questions.length;
                                    index++) {
                                  final question = questions[index].question;
                                  final isObjective =
                                      questions[index].questionType.isObjective;
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
                                      .questionsStructure.questions[index];

                                  final handledItem = QuestionCollectionEntity(
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
                                  final item = collections[level];
                                  if (item == null) {
                                    collections.putIfAbsent(
                                      level,
                                      () => [handledItem],
                                    );
                                  } else {
                                    collections.update(level,
                                        (value) => [...value, handledItem]);
                                  }
                                }
                                // return

                                // ListView.separated(
                                //     physics:
                                //         const NeverScrollableScrollPhysics(),
                                //     shrinkWrap: true,
                                //     separatorBuilder: (context, index) =>
                                //         const SizedBox(
                                //           height: 10,
                                //         ),
                                //     itemCount: questions.length,
                                //     itemBuilder: (context, index) {
                                //       final question =
                                //           questions[index].question;
                                //       final isObjective = questions[index]
                                //           .questionType
                                //           .isObjective;
                                //       final isSingle = questions[index]
                                //           .questionQuantity
                                //           .isSingle;
                                //       final level = questions[index].potLevel;
                                //       final bool isPreview =
                                //           controller.isQuestionsPreview;
                                //       final auxContent = questions[index]
                                //           .subjDoubleValue
                                //           .replaceAll(',', ' ');
                                //       List<String> options = [];
                                //       if (isObjective) {
                                //         options = questions[index].objOptions;
                                //       }
                                //       final questionStructure = controller
                                //           .questionsStructure.questions[index];
                                //       if (question.trim().isEmpty) {
                                //         return const SizedBox();
                                //       }

                                return QuestionCard(
                                  collections: collections,
                                  // level: level,
                                  // question: question,
                                  // isObjective: isObjective,
                                  // options: options,
                                  // isSingle: isSingle,
                                  // auxContent: auxContent,
                                  // constraints: constraints,
                                  // questionStructure: questionStructure,
                                  // questionIndex: index,
                                  // isPreview: isPreview,
                                );
                                // });
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
                                        builder: (context, isLastPage, child) =>
                                            Visibility(
                                          maintainState: true,
                                          visible: isLastPage,
                                          child: Container(
                                              width: constraints.maxWidth,
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                                      Text(('Regras e Termos'),
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
                                                    selector: (_, controller) =>
                                                        controller.acceptTerms,
                                                    builder: (context,
                                                            isSelected,
                                                            child) =>
                                                        InkWell(
                                                      onTap: () {
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
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            300),
                                                                curve: Curves
                                                                    .easeInOut,
                                                              );
                                                            }

                                                            return;
                                                          }

                                                          if (!controller
                                                              .validQuestionFields) {
                                                            InfoDialog.closeAuto(
                                                                'Atenção',
                                                                'Preencha todos os campos para prosseguir',
                                                                context);
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

                                                          await ConfirmDialog.show(
                                                              '',
                                                              "Estas respostas não poderão mais ser alteradas após confirmar.",
                                                              context,
                                                              () async {
                                                            Navigator.pop(
                                                                context);
                                                            controller
                                                                .setLoading(
                                                                    true);
                                                            final couponController =
                                                                Provider.of<
                                                                        CouponSelectController>(
                                                                    context,
                                                                    listen:
                                                                        false);
                                                            final paymentController =
                                                                Provider.of<
                                                                        PaymentController>(
                                                                    context,
                                                                    listen:
                                                                        false);
                                                            final paymentId =
                                                                paymentController
                                                                    .paymentId!;
                                                            final user =
                                                                coreController
                                                                    .user;
                                                            final quickUser =
                                                                coreController
                                                                    .quickUser;

                                                            final userEmail =
                                                                user?.email ??
                                                                    quickUser!
                                                                        .email;
                                                            final userName =
                                                                user?.name ??
                                                                    quickUser!
                                                                        .name;
                                                            final userDocument =
                                                                user?.document ??
                                                                    quickUser!
                                                                        .document;

                                                            final answers =
                                                                controller
                                                                    .questionsStructurePages;
                                                            final amount =
                                                                couponController
                                                                    .totalValue;
                                                            final couponPrice =
                                                                couponController
                                                                    .couponPrice;
                                                            final betId =
                                                                jackController
                                                                    .selectedJackpot!
                                                                    .first
                                                                    .betId;
                                                            final jackpotId =
                                                                jackController
                                                                    .selectedJackpot!
                                                                    .first
                                                                    .id;

                                                            final result = await jackController.createBet(
                                                                paymentId:
                                                                    paymentId,
                                                                userDocument:
                                                                    userDocument,
                                                                userEmail:
                                                                    userEmail,
                                                                userName:
                                                                    userName,
                                                                betId: betId!,
                                                                answers:
                                                                    answers,
                                                                couponPrice:
                                                                    couponPrice);

                                                            if (result &&
                                                                context
                                                                    .mounted) {
                                                              if (controller
                                                                      .betQueue
                                                                      .length >
                                                                  1) {
                                                                final currentBet =
                                                                    controller
                                                                        .selectedJackpot!;
                                                                await jackController.removeTempBet(
                                                                    paymentId:
                                                                        paymentId,
                                                                    userDocument:
                                                                        userDocument,
                                                                    jackpotId:
                                                                        jackpotId);
                                                                controller
                                                                    .betQueue
                                                                    .removeWhere((bet) =>
                                                                        bet.jackpot
                                                                            .id ==
                                                                        currentBet
                                                                            .id);
                                                                final newBet =
                                                                    controller
                                                                        .betQueue
                                                                        .first
                                                                        .jackpot;

                                                                jackController
                                                                    .setSelectedJackpot([
                                                                  newBet
                                                                ]);
                                                                controller
                                                                    .setLoading(
                                                                        false);
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
                                                                controller.startJackpotStructure(
                                                                    newJackpots:
                                                                        controller
                                                                            .betQueue,
                                                                    betAnswers: []);
                                                                // Navigator.pop(
                                                                //     context);
                                                              } else {
                                                                controller
                                                                    .setLoading(
                                                                        true);
                                                                couponController
                                                                    .setCouponsBaseQuantity(
                                                                        CouponsBaseQuantity
                                                                            .five);
                                                                await jackController.removeTempBet(
                                                                    paymentId:
                                                                        paymentId,
                                                                    userDocument:
                                                                        userDocument,
                                                                    jackpotId:
                                                                        jackpotId);
                                                                await InfoDialog
                                                                    .closeAuto(
                                                                        "Sucesso",
                                                                        "Cartela criada com sucesso.\n Aguarde o resultado da partida.",
                                                                        context);

                                                                final myJackpotsController =
                                                                    Provider.of<
                                                                            MyJackpotsController>(
                                                                        context,
                                                                        listen:
                                                                            false);

                                                                final jack =
                                                                    controller
                                                                        .selectedJackpot!;
                                                                await myJackpotsController
                                                                    .getJackpotBetMade(
                                                                        userDocument,
                                                                        jack.id);

                                                                final detailsController =
                                                                    Provider.of<
                                                                            MyJackpotsDetailsController>(
                                                                        context,
                                                                        listen:
                                                                            false);
                                                                final userBets =
                                                                    myJackpotsController
                                                                        .getUserSelectedJackpotBets(
                                                                            jack);

                                                                detailsController
                                                                    .setSelectedBetJackpot(
                                                                        jack);
                                                                detailsController
                                                                    .setSelectedBets(
                                                                        userBets);
                                                                controller
                                                                    .setLoading(
                                                                        false);
                                                                await Navigator.pushNamedAndRemoveUntil(
                                                                    context,
                                                                    AppRoutes
                                                                        .myJackpotsDetails,
                                                                    ModalRoute.withName(
                                                                        AppRoutes
                                                                            .home));

                                                                controller
                                                                    .clearFields();
                                                              }
                                                            } else {
                                                              ErrorDialog.show(
                                                                  "Atenção",
                                                                  "Falha ao criar cartela.\n Contate o suporte.",
                                                                  context);
                                                            }
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
                                          ),
                                          SizedBox(
                                            width:
                                                Responsive.getHeightValue(20),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox(
                                height: Responsive.getHeightValue(20),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String lorem =
      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.';
}
