import '../models/article.dart';
import '../constants/app_assets.dart';

class ArticlesRepository {
  // Mock data for demonstration
  static final List<Article> _mockArticles = [
    Article(
      id: '1',
      title: 'Experience the Serenity of Japan\'s Traditional Countryside',
      content: 'Japan\'s traditional countryside offers a peaceful escape from the bustling cities. With its ancient temples, serene gardens, and traditional architecture, visitors can immerse themselves in centuries-old culture and find tranquility in nature.',
      author: 'Luc Olinga',
      date: 'Apr 17, 2023',
      imageUrl: AppAssets.toriiGate,
      category: 'Travel',
    ),
    Article(
      id: '2',
      title: 'The Pros and Cons of Remote Work',
      content: 'Remote work has become increasingly popular, offering flexibility and work-life balance. However, it also presents challenges such as isolation and communication barriers. This article explores both sides of the remote work phenomenon.',
      author: 'Tech Expert',
      date: 'Apr 20, 2023',
      imageUrl: AppAssets.mountain,
      category: 'Technology',
    ),
    Article(
      id: '3',
      title: 'Uncovering the Hidden Gems of the Amazon Forest',
      content: 'The Amazon rainforest holds countless secrets and biodiversity. From rare species to indigenous communities, this vast ecosystem continues to amaze researchers and adventurers alike.',
      author: 'Mr. Lana Kub',
      date: 'May 1, 2023',
      imageUrl: AppAssets.trees,
      category: 'Travel',
    ),
    Article(
      id: '4',
      title: 'See How the Forest is Helping Our World',
      content: 'Forests are one of the most important natural resources that our planet possesses. Not only do they provide us with a diverse range of products such as timber, medicine, and food, but they also play a vital role in mitigating climate change and maintaining the overall health of our planet\'s ecosystems.',
      author: 'Harry Harper',
      date: 'Apr 12, 2023',
      imageUrl: AppAssets.waterfall,
      category: 'Environment',
    ),
    Article(
      id: '5',
      title: 'Sustainable Business Practices for 2023',
      content: 'As environmental consciousness grows, businesses are adopting sustainable practices to reduce their carbon footprint and appeal to eco-conscious consumers.',
      author: 'Business Leader',
      date: 'May 10, 2023',
      imageUrl: AppAssets.trees,
      category: 'Business',
    ),
    Article(
      id: '6',
      title: 'The Future of Artificial Intelligence',
      content: 'AI technology continues to evolve rapidly, transforming industries and changing how we work and live. This article explores the latest developments and future possibilities.',
      author: 'Tech Expert',
      date: 'May 5, 2023',
      imageUrl: AppAssets.mountain,
      category: 'Technology',
    ),
  ];

  Future<List<Article>> getArticles() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_mockArticles);
  }

  Future<List<Article>> getFeaturedArticles() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockArticles.where((article) => 
      article.category == 'Travel' || article.category == 'Environment'
    ).take(2).toList();
  }

  Future<List<Article>> getPopularArticles() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockArticles.where((article) => 
      article.category == 'Technology'
    ).take(2).toList();
  }

  Future<List<Article>> getArticlesByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockArticles.where((article) => 
      article.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }

  Future<List<Article>> searchArticles(String query) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockArticles.where((article) =>
      article.title.toLowerCase().contains(query.toLowerCase()) ||
      article.content.toLowerCase().contains(query.toLowerCase()) ||
      article.author.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  Future<List<Article>> searchArticlesByCategory(String query, String category) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockArticles.where((article) =>
      article.category.toLowerCase() == category.toLowerCase() &&
      (article.title.toLowerCase().contains(query.toLowerCase()) ||
       article.content.toLowerCase().contains(query.toLowerCase()) ||
       article.author.toLowerCase().contains(query.toLowerCase()))
    ).toList();
  }

  Future<Article?> getArticleById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockArticles.firstWhere((article) => article.id == id);
    } catch (e) {
      return null;
    }
  }
}

