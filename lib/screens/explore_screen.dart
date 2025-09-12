import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_assets.dart';
import '../widgets/explore_article_card.dart';
import '../cubits/articles/articles_cubit.dart';
import '../cubits/articles/articles_state.dart';
import 'search_screen.dart';
import 'article_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  final List<String> _tabs = ['Travel', 'Technology', 'Business'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
      // Load articles for selected category
      final selectedCategory = _tabs[_tabController.index];
      context.read<ArticlesCubit>().loadArticlesByCategory(selectedCategory);
    });
    
    // Load initial articles for first tab
    context.read<ArticlesCubit>().loadArticlesByCategory(_tabs[0]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Status bar simulation
              Container(
                width: double.infinity,
                height: AppDimensions.statusBarHeight,
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        // Signal bars
                        Container(
                          width: 18,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.textPrimary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 4),
                        // WiFi icon
                        Icon(
                          Icons.wifi,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 4),
                        // Battery icon
                        Container(
                          width: 24,
                          height: 12,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.textPrimary, width: 1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: AppColors.textPrimary,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Header with search
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore',
                      style: AppTextStyles.heading1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SearchScreen()),
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: AppDimensions.elevationS,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                          size: AppDimensions.iconM,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Tabs
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors.textPrimary,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  labelColor: AppColors.textWhite,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelStyle: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: AppTextStyles.bodyMedium,
                  tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
                ),
              ),
              
              const SizedBox(height: AppDimensions.paddingM),
              
              // Content
              Expanded(
                child: BlocBuilder<ArticlesCubit, ArticlesState>(
                  builder: (context, state) {
                    if (state is ArticlesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    
                    if (state is ArticlesLoaded) {
                      if (state.articles.isEmpty) {
                        return Center(
                          child: Text(
                            'No articles found',
                            style: AppTextStyles.bodyMedium,
                          ),
                        );
                      }
                      
                      return RefreshIndicator(
                        onRefresh: () async {
                          final selectedCategory = _tabs[_selectedTabIndex];
                          context.read<ArticlesCubit>().loadArticlesByCategory(selectedCategory);
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
                          itemCount: state.articles.length,
                          itemBuilder: (context, index) {
                            final article = state.articles[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
                              child: ExploreArticleCard(
                                imageUrl: article.imageUrl,
                                title: article.title,
                                author: article.author,
                                date: article.date,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArticleScreen(article: article),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                    
                    if (state is ArticlesError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Error loading articles',
                              style: AppTextStyles.bodyMedium,
                            ),
                            const SizedBox(height: AppDimensions.paddingM),
                            ElevatedButton(
                              onPressed: () {
                                final selectedCategory = _tabs[_selectedTabIndex];
                                context.read<ArticlesCubit>().loadArticlesByCategory(selectedCategory);
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }
                    
                    // Default fallback
                    return _buildDefaultContent();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
          child: ExploreArticleCard(
            imageUrl: index == 0 ? AppAssets.trees : 
                     index == 1 ? AppAssets.mountain : AppAssets.waterfall,
            title: index == 0 ? 'Uncovering the Hidden Gems of the Amazon Forest' :
                  index == 1 ? 'Experience the Serenity of Japan\'s Traditional Countryside' :
                  'A Journey Through Time: Discovering the Nile River',
            author: index == 0 ? 'Mr. Lana Kub' :
                   index == 1 ? 'Hana Tanaka' : 'Melissa White',
            date: index == 0 ? 'May 1, 2023' :
                 index == 1 ? 'May 3, 2023' : 'May 2, 2023',
            onTap: () {
              // Navigate to article detail
            },
          ),
        );
      },
    );
  }
}

