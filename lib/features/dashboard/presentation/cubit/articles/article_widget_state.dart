part of 'article_widget_cubit.dart';

sealed class ArticleWidgetState {}

final class ArticleWidgetInitial extends ArticleWidgetState {}

final class ArticleWidgetLoading extends ArticleWidgetState {}

final class ArticleWidgetSuccess extends ArticleWidgetState {
  final List<ArticleItem> articles;

  ArticleWidgetSuccess(this.articles);
}

final class ArticleWidgetError extends ArticleWidgetState {
  final String message;

  ArticleWidgetError(this.message);
}
