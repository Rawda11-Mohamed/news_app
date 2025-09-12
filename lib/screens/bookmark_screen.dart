import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_assets.dart';
import '../widgets/bookmark_item.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  bool _showDeleteDialog = false;
  String _itemToDelete = '';

  final List<Map<String, String>> _bookmarkItems = [
    {
      'title': 'How to Setup Your Workspace',
      'category': 'Interior',
      'image': 'assets/images/workspace.jpg',
    },
    {
      'title': 'Discovering Hidden Gems: 8 Off-The-Beaten-Path...',
      'category': 'Travel',
      'image': AppAssets.trees,
    },
    {
      'title': 'Exploring the World\'s Best Beaches: Top 5 Picks',
      'category': 'Travel',
      'image': AppAssets.waterfall,
    },
    {
      'title': 'Travel Destinations That Won\'t Break the Bank',
      'category': 'Travel',
      'image': AppAssets.mountain,
    },
    {
      'title': 'How Working Remotely Will Make You More Happy',
      'category': 'Business',
      'image': 'assets/images/remote_work.jpg',
    },
    {
      'title': 'Destinations for Authentic Local Experiences',
      'category': 'Business',
      'image': AppAssets.toriiGate,
    },
    {
      'title': 'A Guide to Seasonal Gardening',
      'category': 'Travel',
      'image': 'assets/images/gardening.jpg',
    },
  ];

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
          child: Stack(
            children: [
              Column(
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
                  
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bookmark',
                          style: AppTextStyles.heading1,
                        ),
                      ],
                    ),
                  ),
                  
                  // Bookmarks list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
                      itemCount: _bookmarkItems.length,
                      itemBuilder: (context, index) {
                        final item = _bookmarkItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
                          child: BookmarkItem(
                            title: item['title']!,
                            category: item['category']!,
                            imageUrl: item['image']!,
                            onTap: () {
                              // Navigate to article
                            },
                            onLongPress: () {
                              setState(() {
                                _itemToDelete = item['title']!;
                                _showDeleteDialog = true;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              
              // Delete confirmation dialog
              if (_showDeleteDialog)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: AppColors.textPrimary.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(AppDimensions.paddingL),
                      padding: const EdgeInsets.all(AppDimensions.paddingL),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Sure You want to delete this item?',
                            style: AppTextStyles.heading3,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppDimensions.paddingM),
                          Text(
                            _itemToDelete,
                            style: AppTextStyles.bodyMedium,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: AppDimensions.paddingL),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: AppDimensions.buttonHeight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _bookmarkItems.removeWhere(
                                          (item) => item['title'] == _itemToDelete,
                                        );
                                        _showDeleteDialog = false;
                                        _itemToDelete = '';
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.buttonPrimary,
                                      foregroundColor: AppColors.textWhite,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                                      ),
                                    ),
                                    child: Text(
                                      'Yes, Delete',
                                      style: AppTextStyles.buttonPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppDimensions.paddingM),
                              Expanded(
                                child: SizedBox(
                                  height: AppDimensions.buttonHeight,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _showDeleteDialog = false;
                                        _itemToDelete = '';
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.textPrimary,
                                      side: const BorderSide(color: AppColors.borderLight),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                                      ),
                                    ),
                                    child: Text(
                                      'No',
                                      style: AppTextStyles.buttonSecondary.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

