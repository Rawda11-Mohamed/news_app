import "../../models/article.dart";

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Article> searchResults;
  final String query;
  final String selectedFilter;

  const SearchLoaded({
    required this.searchResults,
    required this.query,
    required this.selectedFilter,
  });
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);
}

