import 'package:aquanotes/features/dashboard/domain/entities/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'article_widget_state.dart';

class ArticleWidgetCubit extends Cubit<ArticleWidgetState> {
  ArticleWidgetCubit() : super(ArticleWidgetInitial());

  List<ArticleItem>? _articles; // Cache for fetched articles
  String _selectedTopic = "SEMUA";

  String get selectedTopic => _selectedTopic;

  Future<void> fetchArticles() async {
    // Avoid re-fetching if data already exists
    if (_articles != null) {
      emit(ArticleWidgetSuccess(_articles!));
      return;
    }

    emit(ArticleWidgetLoading());

    try {
      // Simulate an API call
      await Future.delayed(const Duration(seconds: 2)); // Mock API delay

      // Replace this with your actual API fetching logic
      final fetchedArticles = [
        const ArticleItem(
            imageUrl: "assets/images/aerasea_logo.png",
            title: "TIPS BUDIDAYA",
            subtitle: "TEST",
            type: "TIPS BUDIDAYA"),
        const ArticleItem(
            imageUrl: "assets/images/aerasea_logo.png",
            title: "ARTIKEL",
            subtitle: "TEST",
            type: "ARTIKEL"),
        const ArticleItem(
            imageUrl: "assets/images/aerasea_logo.png",
            title: "TESTIMONI",
            subtitle: "TEST",
            type: "TESTIMONI"),
      ];
      _articles = fetchedArticles; // Cache the fetched data
      emit(ArticleWidgetSuccess(fetchedArticles));
    } catch (e) {
      emit(ArticleWidgetError('Failed to fetch articles: $e'));
    }
  }

  void filterArticles(String query) {
    _selectedTopic = query;
    emit(ArticleWidgetLoading());
    if (_articles == null) return;

    if (query == "SEMUA") {
      emit(ArticleWidgetSuccess(_articles!));
      return;
    }

    final filteredArticles =
        _articles!.where((article) => article.type == query).toList();

    emit(ArticleWidgetSuccess(filteredArticles));
  }
}
