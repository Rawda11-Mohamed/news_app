import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';

class BookmarksRepository {
  static const String _bookmarksKey = 'bookmarked_articles';

  Future<List<Article>> getBookmarkedArticles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];
      
      return bookmarksJson.map((json) => 
        Article.fromJson(jsonDecode(json))
      ).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addBookmark(Article article) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];
      
      // Check if article is already bookmarked
      final isAlreadyBookmarked = bookmarksJson.any((json) {
        final existingArticle = Article.fromJson(jsonDecode(json));
        return existingArticle.id == article.id;
      });
      
      if (!isAlreadyBookmarked) {
        final bookmarkedArticle = article.copyWith(isBookmarked: true);
        bookmarksJson.add(jsonEncode(bookmarkedArticle.toJson()));
        await prefs.setStringList(_bookmarksKey, bookmarksJson);
      }
    } catch (e) {
      throw Exception('Failed to add bookmark: $e');
    }
  }

  Future<void> removeBookmark(String articleId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];
      
      bookmarksJson.removeWhere((json) {
        final article = Article.fromJson(jsonDecode(json));
        return article.id == articleId;
      });
      
      await prefs.setStringList(_bookmarksKey, bookmarksJson);
    } catch (e) {
      throw Exception('Failed to remove bookmark: $e');
    }
  }

  Future<bool> isBookmarked(String articleId) async {
    try {
      final bookmarkedArticles = await getBookmarkedArticles();
      return bookmarkedArticles.any((article) => article.id == articleId);
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAllBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_bookmarksKey);
    } catch (e) {
      throw Exception('Failed to clear bookmarks: $e');
    }
  }
}

