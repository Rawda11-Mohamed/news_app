import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';

class BookmarkItem extends StatelessWidget {
  final String title;
  final String category;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const BookmarkItem({
    Key? key,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
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
                width: 80,
                height: 80,
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
                      style: AppTextStyles.articleTitle.copyWith(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimensions.paddingXS),
                    Text(
                      category,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bookmark icon
            Padding(
              padding: const EdgeInsets.only(right: AppDimensions.paddingM),
              child: Icon(
                Icons.bookmark,
                color: AppColors.primary,
                size: AppDimensions.iconS,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

