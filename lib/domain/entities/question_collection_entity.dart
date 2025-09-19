import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/question_structure_entity.dart';

class QuestionCollectionEntity {
  QuestionCollectionEntity({
    required this.question,
    required this.isObjective,
    required this.options,
    required this.isSingle,
    required this.isPreview,
    required this.auxContent,
    required this.constraints,
    required this.level,
    required this.questionIndex,
    required this.questionStructure,
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
}
