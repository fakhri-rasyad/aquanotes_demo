part of 'questions_widget_cubit.dart';

sealed class QuestionsWidgetState {}

final class QuestionsWidgetInitial extends QuestionsWidgetState {}

final class QuestionWidgetLoading extends QuestionsWidgetState {}

final class QuestionWidgetSuccess extends QuestionsWidgetState {
  final List<Question> questions;

  QuestionWidgetSuccess(this.questions);
}

final class QuestionWidgetError extends QuestionsWidgetState {
  final String message;

  QuestionWidgetError(this.message);
}
