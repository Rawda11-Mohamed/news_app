import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_assets.dart';
import '../widgets/article_card.dart';
import '../widgets/featured_article_card.dart';
import '../cubits/articles/articles_cubit.dart';
import '../cubits/articles/articles_state.dart';
import '../cubits/user/user_cubit.dart';
import '../cubits/user/user_state.dart';
import '../cubits/weather/weather_cubit.dart';
import '../cubits/weather/weather_state.dart';
import 'article_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load initial data
    context.read<ArticlesCubit>().loadArticles();
    context.read<UserCubit>().loadUser();
    context.read<WeatherCubit>().getWeather();
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
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<ArticlesCubit>().refreshArticles();
              context.read<WeatherCubit>().refreshWeather();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  
                  const SizedBox(height: AppDimensions.paddingM),
                  
                  // Greeting section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, userState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Morning,',
                                style: AppTextStyles.greeting,
                              ),
                              Text(
                                userState is UserLoaded 
                                    ? userState.user.name 
                                    : 'Ahmed Saber',
                                style: AppTextStyles.greetingName,
                              ),
                              const SizedBox(height: AppDimensions.paddingXS),
                              Text(
                                'Sun 9 April, 2023',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          );
                        },
                      ),
                      BlocBuilder<WeatherCubit, WeatherState>(
                        builder: (context, weatherState) {
                          if (weatherState is WeatherLoaded) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.wb_sunny,
                                  color: AppColors.weatherIconColor,
                                  size: AppDimensions.iconM,
                                ),
                                const SizedBox(width: AppDimensions.paddingXS),
                                Text(
                                  'Sunny ${weatherState.weather.temperature.round()}°C',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            );
                          }
                          return Row(
                            children: [
                              Icon(
                                Icons.wb_sunny,
                                color: AppColors.weatherIconColor,
                                size: AppDimensions.iconM,
                              ),
                              const SizedBox(width: AppDimensions.paddingXS),
                              Text(
                                'Sunny 32°C',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppDimensions.paddingL),
                  
                  // Featured article
                  BlocBuilder<ArticlesCubit, ArticlesState>(
                    builder: (context, state) {
                      if (state is ArticlesLoaded && state.featuredArticles.isNotEmpty) {
                        final featuredArticle = state.featuredArticles.first;
                        return FeaturedArticleCard(
                          imageUrl: featuredArticle.imageUrl,
                          title: featuredArticle.title,
                          author: featuredArticle.author,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleScreen(article: featuredArticle),
                              ),
                            );
                          },
                        );
                      }
                      return FeaturedArticleCard(
                        imageUrl: AppAssets.toriiGate,
                        title: 'Experience the Serenity of Japan\'s Traditional Countryside',
                        author: 'Luc Olinga',
                        onTap: () {
                          // Navigate to article detail
                        },
                      );
                    },
                  ),
                  
                  const SizedBox(height: AppDimensions.paddingL),
                  
                  // Most Popular section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Most Popular',
                        style: AppTextStyles.heading2,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to see more
                        },
                        child: Text(
                          'See More',
                          style: AppTextStyles.buttonSecondary,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppDimensions.paddingM),
                  
                  // Popular articles
                  BlocBuilder<ArticlesCubit, ArticlesState>(
                    builder: (context, state) {
                      if (state is ArticlesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      
                      if (state is ArticlesLoaded) {
                        final popularArticles = state.popularArticles.isNotEmpty 
                            ? state.popularArticles.take(2).toList()
                            : state.articles.take(2).toList();
                            
                        return Row(
                          children: [
                            if (popularArticles.isNotEmpty)
                              Expanded(
                                child: ArticleCard(
                                  imageUrl: popularArticles[0].imageUrl,
                                  title: popularArticles[0].title,
                                  category: popularArticles[0].category,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ArticleScreen(article: popularArticles[0]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            if (popularArticles.length > 1) ...[
                              const SizedBox(width: AppDimensions.paddingM),
                              Expanded(
                                child: ArticleCard(
                                  imageUrl: popularArticles[1].imageUrl,
                                  title: popularArticles[1].title,
                                  category: popularArticles[1].category,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ArticleScreen(article: popularArticles[1]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ],
                        );
                      }
                      
                      if (state is ArticlesError) {
                        return Center(
                          child: Text(
                            'Error loading articles: ${state.message}',
                            style: AppTextStyles.bodyMedium,
                          ),
                        );
                      }
                      
                      // Default fallback
                      return Row(
                        children: [
                          Expanded(
                            child: ArticleCard(
                              imageUrl: AppAssets.mountain,
                              title: 'The Pros and Cons of Remote Work',
                              category: 'Technology',
                              onTap: () {
                                // Navigate to article detail
                              },
                            ),
                          ),
                          const SizedBox(width: AppDimensions.paddingM),
                          Expanded(
                            child: ArticleCard(
                              imageUrl: AppAssets.waterfall,
                              title: 'The Pros and Cons of Remote Work',
                              category: 'Technology',
                              onTap: () {
                                // Navigate to article detail
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  
                  const SizedBox(height: AppDimensions.paddingXL),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

