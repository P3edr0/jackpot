import 'package:flutter/material.dart';
import 'package:jackpot/components/textfields/small_textfield.dart';
import 'package:jackpot/domain/entities/double_subjective_question.dart';
import 'package:jackpot/domain/entities/objective_question_entity.dart';
import 'package:jackpot/domain/entities/question_structure_entity.dart';
import 'package:jackpot/domain/entities/single_subjective_question.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_questions/store/jackpot_questions_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.isObjective,
    required this.options,
    required this.isSingle,
    required this.auxContent,
    required this.constraints,
    required this.level,
    required this.questionIndex,
    required this.questionStructure,
    required this.isPreview,
  });

  final String question;
  final bool isObjective;
  final List<String> options;
  final bool isSingle;
  final bool isPreview;
  final String auxContent;
  final BoxConstraints constraints;
  final int level;
  final int questionIndex;
  final QuestionStructureEntity questionStructure;

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
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: const BoxDecoration(
              color: transparent,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          width: widget.constraints.maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              levelCard(widget.level, widget.constraints),
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
                          levelInfo(widget.level),
                          style: JackFontStyle.bodyBold,
                        ),
                        SizedBox(height: Responsive.getHeightValue(10)),
                        Text(
                          widget.question,
                          style: JackFontStyle.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        if (widget.isObjective)
                          GridView.builder(
                              padding: const EdgeInsets.only(top: 16),
                              addAutomaticKeepAlives: true,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.options.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 8,
                                childAspectRatio: 3,
                              ),
                              itemBuilder: (context, optionIndex) {
                                final objectiveQuestionStructure =
                                    widget.questionStructure
                                        as ObjectiveQuestionEntity;
                                bool isSelected = objectiveQuestionStructure
                                    .selectedList[optionIndex];
                                return Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      if (widget.isPreview) return;
                                      controller.setSelectedOption(
                                          widget.questionIndex, optionIndex);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        isSelected
                                            ? const Icon(Icons.check_box)
                                            : const Icon(
                                                Icons.check_box_outline_blank),
                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: Text(
                                            widget.options[optionIndex],
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        if (!widget.isObjective && widget.isSingle)
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            width: Responsive.getHeightValue(80),
                            decoration: BoxDecoration(
                              border: Border.all(color: lightGrey, width: 2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: JackSmallTextfield(
                              enable: !widget.isPreview,
                              onChanged: (value) =>
                                  controller.checkCanSkipPage(),
                              controller: (widget.questionStructure
                                      as SingleSubjectiveQuestionEntity)
                                  .controller,
                              hint: '00',
                            ),
                          ),
                        if (!widget.isObjective && !widget.isSingle)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: Responsive.getHeightValue(64),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: lightGrey, width: 2),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: JackSmallTextfield(
                                        enable: !widget.isPreview,
                                        onChanged: (value) =>
                                            controller.checkCanSkipPage(),
                                        controller: (widget.questionStructure
                                                as DoubleSubjectiveQuestionEntity)
                                            .firstController,
                                        hint: '00',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: Responsive.getHeightValue(64),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: lightGrey, width: 2),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: JackSmallTextfield(
                                        enable: !widget.isPreview,
                                        controller: (widget.questionStructure
                                                as DoubleSubjectiveQuestionEntity)
                                            .secondController,
                                        hint: '00',
                                        onChanged: (value) =>
                                            controller.checkCanSkipPage(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(widget.auxContent)
                            ],
                          ),
                      ],
                    ));
              }),
            ],
          ),
        ),
        Positioned(
            top: 0, right: 5, child: Image.asset(levelCrown(widget.level)))
      ],
    );
  }
}

Widget levelCard(int level, BoxConstraints constraints) {
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
