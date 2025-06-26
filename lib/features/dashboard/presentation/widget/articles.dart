import 'package:aquanotes/features/dashboard/domain/entities/article.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/articles/article_widget_cubit.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlesWidget extends StatefulWidget {
  const ArticlesWidget({super.key});

  @override
  State<ArticlesWidget> createState() => _ArticlesWidgetState();
}

class _ArticlesWidgetState extends State<ArticlesWidget> {
  @override
  void initState() {
    super.initState();
    // Call the Cubit's fetch method when the widget initializes
    context.read<ArticleWidgetCubit>().fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize:
          MainAxisSize.min, // Ensures the column takes only required space
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Bacaan",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const ArticlesTopicRow(),
        const SizedBox(height: 12.0),
        BlocConsumer<ArticleWidgetCubit, ArticleWidgetState>(
          listener: (context, state) {
            if (state is ArticleWidgetError) {
              // Show a snackbar when an error occurs
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is ArticleWidgetLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ArticleWidgetSuccess) {
              return ArticlesCardColumn(articles: state.articles);
            } else if (state is ArticleWidgetError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text("No articles available."));
            }
          },
        ),
      ],
    );
  }
}

class ArticlesTopicRow extends StatelessWidget {
  const ArticlesTopicRow({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> topics = [
      "SEMUA",
      "TIPS BUDIDAYA",
      "ARTIKEL",
      "TESTIMONI",
      "HASIL"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: topics.map((topic) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                context.read<ArticleWidgetCubit>().filterArticles(topic);
              },
              child: BlocBuilder<ArticleWidgetCubit, ArticleWidgetState>(
                builder: (context, state) {
                  final selectedTopic =
                      context.read<ArticleWidgetCubit>().selectedTopic;
                  final isSelected = selectedTopic == topic;

                  return ArticlesTopicRowItem(
                    name: topic,
                    isSelected: isSelected,
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ArticlesTopicRowItem extends StatelessWidget {
  final String name;
  final bool isSelected;

  const ArticlesTopicRowItem(
      {super.key, required this.name, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: isSelected ? AppColors.gradientStart : AppColors.fadeLightBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color:
                isSelected ? AppColors.fadeLightBlue : AppColors.gradientStart,
          ),
        ),
      ),
    );
  }
}

class ArticlesCardColumn extends StatelessWidget {
  final List<ArticleItem> articles;

  const ArticlesCardColumn({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    // Limit the articles to a maximum of 4 items
    final limitedArticles = articles.take(4).toList();

    return ListView.separated(
      shrinkWrap: true, // Ensures the ListView takes only the required height
      physics: const NeverScrollableScrollPhysics(), // Disables scrolling
      itemCount: limitedArticles.length,
      itemBuilder: (context, index) {
        return ArticlesCardColumnItem(article: limitedArticles[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 8.0, // Add space between cards
      ),
    );
  }
}

class ArticlesCardColumnItem extends StatelessWidget {
  final ArticleItem article;

  const ArticlesCardColumnItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.fadeLightBlue,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        leading: Image.asset(
          article.imageUrl,
          height: 48.0,
          width: 48.0,
          fit: BoxFit.cover,
        ),
        title: Text(
          article.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          article.subtitle,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 16.0,
        ),
        onTap: () {
          // Add your navigation or click logic here
        },
      ),
    );
  }
}
