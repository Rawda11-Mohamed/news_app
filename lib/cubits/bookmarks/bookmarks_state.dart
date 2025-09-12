import '../../models/article.dart';

abstract class BookmarksState {
  const BookmarksState();
}

class BookmarksInitial extends BookmarksState {}

class BookmarksLoading extends BookmarksState {}

class BookmarksLoaded extends BookmarksState {
  final List<Article> bookmarkedArticles;

  const BookmarksLoaded(this.bookmarkedArticles);
}

class BookmarksError extends BookmarksState {
  final String message;

  const BookmarksError(this.message);
}

