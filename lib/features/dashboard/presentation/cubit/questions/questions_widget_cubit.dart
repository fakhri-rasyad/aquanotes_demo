import 'package:aquanotes/features/dashboard/domain/entities/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'questions_widget_state.dart';

class QuestionsWidgetCubit extends Cubit<QuestionsWidgetState> {
  QuestionsWidgetCubit() : super(QuestionsWidgetInitial());

  void getQuestions() async {
    emit(QuestionWidgetLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      List<Question> question = [
        const Question(
            title: "Bagaimana cara mengunduh data grafik monitoring?",
            content:
                "Silahkan masuk ke menu monitoring dan klik icon unduh di sebelah kanan atas. Data akan tersimpan otomatis dalam ekstensi .csv"),
        const Question(
            title: "Bagaimana prinsip kerja sistem cerdas Aquanotes?",
            content: "Lorem Ipsum Si Amet"),
        const Question(
            title:
                "Apakah Aquanotes mesti terhubung ke internet dulu lalu bisa digunakan?",
            content: "Lorem Ipsum Si Amet"),
        const Question(
            title:
                "Apakah Aplikasi Aquanotes perlu dikonfigurasi ke Aquanotes Box terlebih dahulu?",
            content: "Lorem Ipsum Si Amet")
      ];
      emit(QuestionWidgetSuccess(question));
    } catch (e) {
      emit(QuestionWidgetError("Failed to retrieve Question $e"));
    }
  }
}
