import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';

class ExploreArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String date;
  final VoidCallback onTap;

  const ExploreArticleCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
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
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppDimensions.radiusM),
                bottomLeft: Radius.circular(AppDimensions.radiusM),
              ),
              child: Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.articleTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimensions.paddingS),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.textLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.paddingXS),
                        Expanded(
                          child: Text(
                            author,
                            style: AppTextStyles.articleAuthor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingXS),
                    Text(
                      date,
                      style: AppTextStyles.articleDate,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

