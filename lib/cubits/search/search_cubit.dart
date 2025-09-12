import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/articles_repository.dart';
import '../../models/article.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ArticlesRepository _articlesRepository;

  SearchCubit(this._articlesRepository) : super(SearchInitial());

  Future<void> searchArticles(String query, {String filter = 'All'}) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    try {
      emit(SearchLoading());
      
      List<Article> results;
      
      if (filter == 'All') {
        results = await _articlesRepository.searchArticles(query);
      } else {
        results = await _articlesRepository.searchArticlesByCategory(query, filter);
      }
      
      emit(SearchLoaded(
        searchResults: results,
        query: query,
        selectedFilter: filter,
      ));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void changeFilter(String filter) {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      searchArticles(currentState.query, filter: filter);
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}

