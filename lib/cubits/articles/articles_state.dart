import 'package:khaber_app/models/article.dart';
abstract class ArticlesState {
  const ArticlesState();}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesLoaded extends ArticlesState {
  final List<Article> articles;
  final List<Article> featuredArticles;
  final List<Article> popularArticles;

  const ArticlesLoaded({
    required this.articles,
    required this.featuredArticles,
    required this.popularArticles,
  });
}

class ArticlesError extends ArticlesState {
  final String message;

  const ArticlesError(this.message);
}

