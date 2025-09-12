import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/bookmarks_repository.dart';
import '../../models/article.dart';
import 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  final BookmarksRepository _bookmarksRepository;

  BookmarksCubit(this._bookmarksRepository) : super(BookmarksInitial());

  Future<void> loadBookmarks() async {
    try {
      emit(BookmarksLoading());
      
      final bookmarkedArticles = await _bookmarksRepository.getBookmarkedArticles();
      
      emit(BookmarksLoaded(bookmarkedArticles));
    } catch (e) {
      emit(BookmarksError(e.toString()));
    }
  }

  Future<void> addBookmark(Article article) async {
    try {
      await _bookmarksRepository.addBookmark(article);
      
      // Reload bookmarks to reflect changes
      loadBookmarks();
    } catch (e) {
      emit(BookmarksError(e.toString()));
    }
  }

  Future<void> removeBookmark(String articleId) async {
    try {
      await _bookmarksRepository.removeBookmark(articleId);
      
      // Reload bookmarks to reflect changes
      loadBookmarks();
    } catch (e) {
      emit(BookmarksError(e.toString()));
    }
  }

  Future<bool> isBookmarked(String articleId) async {
    try {
      return await _bookmarksRepository.isBookmarked(articleId);
    } catch (e) {
      return false;
    }
  }

  void refreshBookmarks() {
    loadBookmarks();
  }
}

