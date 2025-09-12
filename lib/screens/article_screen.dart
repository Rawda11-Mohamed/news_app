import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_assets.dart';
import '../models/article.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({Key? key, required this.article}) : super(key: key);

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
          child: SingleChildScrollView(
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
                      ),]
                    ),
                  ),

                // Header image
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/forest_river.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Gradient overlay
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.textPrimary.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),

                      // Action buttons
                      Positioned(
                        top: AppDimensions.paddingM,
                        left: AppDimensions.paddingM,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: AppColors.textPrimary,
                              size: AppDimensions.iconS,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: AppDimensions.paddingM,
                        right: AppDimensions.paddingM,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Bookmark action
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.cardBackground.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.bookmark_border,
                                  color: AppColors.textPrimary,
                                  size: AppDimensions.iconS,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppDimensions.paddingS),
                            GestureDetector(
                              onTap: () {
                                // Share action
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.cardBackground.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.share,
                                  color: AppColors.textPrimary,
                                  size: AppDimensions.iconS,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Article content
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.radiusXL),
                      topRight: Radius.circular(AppDimensions.radiusXL),
                    ),
                  ),
                  padding: const EdgeInsets.all(AppDimensions.paddingL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Article title
                      Text(
                        'See How the Forest is Helping Our World',
                        style: AppTextStyles.heading1,
                      ),

                      const SizedBox(height: AppDimensions.paddingM),

                      // Author info
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.textLight,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.paddingM),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Harry Harper',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Apr 12, 2023',
                                style: AppTextStyles.articleDate,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimensions.paddingL),

                      // Article content
                      Text(
                        'Forests are one of the most important natural resources that our planet possesses. Not only do they provide us with a diverse range of products such as timber, medicine, and food, but they also play a vital role in mitigating climate change and maintaining the overall health of our planet\'s ecosystems. In this article, we will explore the ways in which forests are helping our world.',
                        style: AppTextStyles.bodyLarge,
                      ),

                      const SizedBox(height: AppDimensions.paddingM),

                      Text(
                        'One of the most important roles that forests play is in absorbing carbon dioxide from the atmosphere. Trees absorb carbon dioxide through photosynthesis and store it in their trunks, branches, and leaves. This carbon dioxide absorption helps to reduce the amount of greenhouse gases in the atmosphere, which in turn helps to mitigate climate change.',
                        style: AppTextStyles.bodyLarge,
                      ),

                      const SizedBox(height: AppDimensions.paddingXL),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

