import 'package:aquanotes/features/dashboard/domain/entities/question.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/questions/questions_widget_cubit.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FrequentAskedQuestion extends StatefulWidget {
  const FrequentAskedQuestion({super.key});

  @override
  State<FrequentAskedQuestion> createState() => _FrequentAskedQuestionState();
}

class _FrequentAskedQuestionState extends State<FrequentAskedQuestion> {
  @override
  void initState() {
    super.initState();
    context.read<QuestionsWidgetCubit>().getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pertanyaan Umum",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Implement "Lihat Semua" navigation logic
                  },
                  child: const Text(
                    "Lihat Semua",
                    style: TextStyle(color: AppColors.gradientEnd),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<QuestionsWidgetCubit, QuestionsWidgetState>(
            builder: (context, state) {
              if (state is QuestionWidgetLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is QuestionWidgetSuccess) {
                if (state.questions.isEmpty) {
                  return const Center(
                    child: Text("No Questions Available"),
                  );
                }
                return FrequentlyAskedQuestionColumn(
                    questions: state.questions);
              } else if (state is QuestionWidgetError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text("No Questions Available"));
              }
            },
          ),
        ],
      ),
    );
  }
}

class FrequentlyAskedQuestionColumn extends StatelessWidget {
  final List<Question> questions;

  const FrequentlyAskedQuestionColumn({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return FrequentlyAskedQuestionItem(question: questions[index]);
      },
      separatorBuilder: (context, index) =>
          const SizedBox(height: 8.0), // Add space between items
    );
  }
}

class FrequentlyAskedQuestionItem extends StatefulWidget {
  final Question question;

  const FrequentlyAskedQuestionItem({super.key, required this.question});

  @override
  State<FrequentlyAskedQuestionItem> createState() =>
      _FrequentlyAskedQuestionItemState();
}

class _FrequentlyAskedQuestionItemState
    extends State<FrequentlyAskedQuestionItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: AppColors.gradientEnd, width: 2),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: AppColors.gradientEnd, width: 2),
        ),
        collapsedBackgroundColor: AppColors.fadeLightBlue,
        backgroundColor: AppColors.gradientStart.withAlpha(7),
        collapsedIconColor: AppColors.gradientEnd,
        iconColor: AppColors.gradientEnd,
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        title: Text(
          widget.question.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          _isExpanded ? Icons.minimize_rounded : Icons.add,
          color: AppColors.gradientEnd,
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Text(
            widget.question.content,
          ),
        ],
      ),
    );
  }
}
