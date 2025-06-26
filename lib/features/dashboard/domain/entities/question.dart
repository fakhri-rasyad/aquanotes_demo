import 'package:equatable/equatable.dart';

class Question extends Equatable{

  final String title;
  final String content;

  const Question({
    required this.title,
    required this.content
});

  @override
  List<Object?> get props => [title, content];

}