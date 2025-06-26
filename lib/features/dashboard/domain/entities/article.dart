import 'package:equatable/equatable.dart';

class ArticleItem extends Equatable{
  final String imageUrl;
  final String title;
  final String subtitle;
  final String type;

  const ArticleItem({required this.imageUrl, required this.title, required this.subtitle, required this.type});

  @override
  List<Object?> get props => [imageUrl, title, subtitle, type];
}