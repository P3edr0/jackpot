import 'package:flutter/material.dart';
import 'package:jackpot/components/textfields/small_textfield.dart';
import 'package:jackpot/domain/entities/double_subjective_question.dart';
import 'package:jackpot/domain/entities/objective_question_entity.dart';
import 'package:jackpot/domain/entities/question_collection_entity.dart';
import 'package:jackpot/domain/entities/single_subjective_question.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/store/jackpot_questions_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard(
      {super.key,
      // required this.question,
      // required this.isObjective,
      // required this.options,
      // required this.isSingle,
      // required this.auxContent,
      // required this.constraints,
      // required this.level,
      // required this.questionIndex,
      // required this.questionStructure,
      // required this.isPreview,
      required this.collections});

  // final String question;
  // final bool isObjective;
  // final List<String> options;
  // final bool isSingle;
  // final bool isPreview;
  // final String auxContent;
  // final BoxConstraints constraints;
  // final int level;
  // final int questionIndex;
  // final QuestionStructureEntity questionStructure;
  final Map<int, List<QuestionCollectionEntity>> collections;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

late JackpotQuestionsController controller;

class _QuestionCardState extends State<QuestionCard> {
  @override
  void initState() {
    super.initState();
    controller =
        Provider.of<JackpotQuestionsController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: widget.collections.length,
        itemBuilder: (context, index) {
          // final question =
          //     questions[index].question;
          // final isObjective = questions[index]
          //     .questionType
          //     .isObjective;
          // final isSingle = questions[index]
          //     .questionQuantity
          //     .isSingle;
          // final level = questions[index].potLevel;
          // final bool isPreview =
          //     controller.isQuestionsPreview;
          // final auxContent = questions[index]
          //     .subjDoubleValue
          //     .replaceAll(',', ' ');
          // List<String> options = [];
          // if (isObjective) {
          //   options = questions[index].objOptions;
          // }
          // final questionStructure = controller
          //     .questionsStructure.questions[index];
          // if (question.trim().isEmpty) {
          //   return const SizedBox();
          // }
          final currentCollection = widget.collections[index + 1];
          return Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                decoration: const BoxDecoration(
                    color: transparent,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                width: currentCollection!.first.constraints.maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    levelPrizeCard(currentCollection.first.level,
                        currentCollection.first.constraints),
                    LayoutBuilder(builder: (context, constraints) {
                      return Container(
                          width: constraints.maxWidth,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: mediumGrey.withOpacity(0.4),
                                  offset: const Offset(0, 4),
                                  blurRadius: 0.8,
                                  spreadRadius: 0.5,
                                )
                              ],
                              color: secondaryColor),
                          child: Column(
                            children: [
                              Text(
                                levelInfo(currentCollection.first.level),
                                style: JackFontStyle.bodyBold,
                              ),
                              SizedBox(height: Responsive.getHeightValue(10)),
////////////////////

                              ...currentCollection.map((item) {
                                final bool isLast =
                                    currentCollection.last.question ==
                                        item.question;

                                return Column(
                                  children: [
                                    Text(
                                      item.question,
                                      style: JackFontStyle.bodyLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                    if (item.isObjective)
                                      GridView.builder(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          addAutomaticKeepAlives: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: item.options.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 150,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 8,
                                            childAspectRatio: 3,
                                          ),
                                          itemBuilder: (context, optionIndex) {
                                            final objectiveQuestionStructure =
                                                item.questionStructure
                                                    as ObjectiveQuestionEntity;
                                            bool isSelected =
                                                objectiveQuestionStructure
                                                    .selectedList[optionIndex];
                                            return Container(
                                              height: 40,
                                              alignment: Alignment.center,
                                              child: InkWell(
                                                onTap: () {
                                                  if (item.isPreview) return;
                                                  controller.setSelectedOption(
                                                      item.questionIndex,
                                                      optionIndex);
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    isSelected
                                                        ? const Icon(
                                                            Icons.check_box)
                                                        : const Icon(Icons
                                                            .check_box_outline_blank),
                                                    const SizedBox(width: 6),
                                                    Flexible(
                                                      child: Text(
                                                        item.options[
                                                            optionIndex],
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    if (!item.isObjective && item.isSingle)
                                      Container(
                                        margin: const EdgeInsets.only(top: 16),
                                        width: Responsive.getHeightValue(80),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: lightGrey, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: JackSmallTextfield(
                                          enable: !item.isPreview,
                                          onChanged: (value) =>
                                              controller.checkCanSkipPage(),
                                          controller: (item.questionStructure
                                                  as SingleSubjectiveQuestionEntity)
                                              .controller,
                                          hint: '00',
                                        ),
                                      ),
                                    if (!item.isObjective && !item.isSingle)
                                      Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width:
                                                      Responsive.getHeightValue(
                                                          64),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: lightGrey,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: JackSmallTextfield(
                                                    enable: !item.isPreview,
                                                    onChanged: (value) =>
                                                        controller
                                                            .checkCanSkipPage(),
                                                    controller: (item
                                                                .questionStructure
                                                            as DoubleSubjectiveQuestionEntity)
                                                        .firstController,
                                                    hint: '00',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width:
                                                      Responsive.getHeightValue(
                                                          64),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: lightGrey,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: JackSmallTextfield(
                                                    enable: !item.isPreview,
                                                    controller: (item
                                                                .questionStructure
                                                            as DoubleSubjectiveQuestionEntity)
                                                        .secondController,
                                                    hint: '00',
                                                    onChanged: (value) =>
                                                        controller
                                                            .checkCanSkipPage(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(item.auxContent)
                                        ],
                                      ),
                                    if (!isLast) ...[
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ]
                                  ],
                                );
                              })
                            ],
                          ));
                    }),
                  ],
                ),
              ),
              Positioned(top: 0, right: 5, child: Image.asset(levelCrown(3)))
            ],
          );
        });
  }
}

Widget levelPrizeCard(int level, BoxConstraints constraints) {
  switch (level) {
    // case 1:
    //   return Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //     decoration: const BoxDecoration(
    //         color: bronze,
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    //     width: constraints.maxWidth,
    //     child: Text(
    //       'POTE BRONZE - Prêmio 20% do valor total',
    //       style: JackFontStyle.body
    //           .copyWith(color: secondaryColor, fontWeight: FontWeight.w900),
    //     ),
    //   );
    // case 2:
    //   return Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //     decoration: const BoxDecoration(
    //         color: silver,
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    //     width: constraints.maxWidth,
    //     child: Text(
    //       'POTE PRATA - Prêmio 50% do valor total',
    //       style: JackFontStyle.body
    //           .copyWith(color: secondaryColor, fontWeight: FontWeight.w900),
    //     ),
    //   );

    default:
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
            color: gold,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        width: constraints.maxWidth,
        child: Text(
          'POTE $levelº PRÊMIO',
          style: JackFontStyle.body
              .copyWith(color: secondaryColor, fontWeight: FontWeight.w900),
        ),
      );
  }
}

Widget levelPotCard(int level, BoxConstraints constraints) {
  switch (level) {
    case 1:
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
            color: bronze,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        width: constraints.maxWidth,
        child: Text(
          'POTE BRONZE - Prêmio 20% do valor total',
          style: JackFontStyle.body
              .copyWith(color: secondaryColor, fontWeight: FontWeight.w900),
        ),
      );
    case 2:
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
            color: silver,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        width: constraints.maxWidth,
        child: Text(
          'POTE PRATA - Prêmio 50% do valor total',
          style: JackFontStyle.body
              .copyWith(color: secondaryColor, fontWeight: FontWeight.w900),
        ),
      );

    default:
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
            color: gold,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        width: constraints.maxWidth,
        child: Text(
          'POTE OURO - Prêmio 100% do valor total',
          style: JackFontStyle.body
              .copyWith(color: secondaryColor, fontWeight: FontWeight.w900),
        ),
      );
  }
}

String levelCrown(int level) {
  switch (level) {
    case 1:
      return AppAssets.bronzeCrown;
    case 2:
      return AppAssets.silverCrown;
    default:
      return AppAssets.goldCrown;
  }
}

String levelInfo(int level) {
  switch (level) {
    case 1:
      return '';
    case 2:
      return 'ACERTAR TODOS OS BRONZES +';
    default:
      return 'ACERTAR TODOS DO BRONZES E PRATA +';
  }
}
