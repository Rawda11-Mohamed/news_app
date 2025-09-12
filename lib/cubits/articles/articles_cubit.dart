import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/articles_repository.dart';
import '../../models/article.dart';
import 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final ArticlesRepository _articlesRepository;

  ArticlesCubit(this._articlesRepository) : super(ArticlesInitial());

  Future<void> loadArticles() async {
    try {
      emit(ArticlesLoading());
      
      final articles = await _articlesRepository.getArticles();
      final featuredArticles = await _articlesRepository.getFeaturedArticles();
      final popularArticles = await _articlesRepository.getPopularArticles();
      
      emit(ArticlesLoaded(
        articles: articles,
        featuredArticles: featuredArticles,
        popularArticles: popularArticles,
      ));
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }

  Future<void> loadArticlesByCategory(String category) async {
    try {
      emit(ArticlesLoading());
      
      final articles = await _articlesRepository.getArticlesByCategory(category);
      
      emit(ArticlesLoaded(
        articles: articles,
        featuredArticles: [],
        popularArticles: [],
      ));
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }

  Future<void> searchArticles(String query) async {
    try {
      emit(ArticlesLoading());
      
      final articles = await _articlesRepository.searchArticles(query);
      
      emit(ArticlesLoaded(
        articles: articles,
        featuredArticles: [],
        popularArticles: [],
      ));
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }

  void refreshArticles() {
    loadArticles();
  }
}

