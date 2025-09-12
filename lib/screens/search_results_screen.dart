import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_assets.dart';
import '../widgets/search_result_card.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late TextEditingController _searchController;
  int _selectedFilterIndex = 0;

  final List<Map<String, dynamic>> _filters = [
    {'label': 'All', 'count': 132},
    {'label': 'Travel', 'count': 51},
    {'label': 'Technology', 'count': 116},
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query);
  }

  @override
  void dispose() {
    _searchController.dispose();
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
                        Container(
                          width: 18,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.textPrimary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.wifi, size: 16, color: AppColors.textPrimary),
                        const SizedBox(width: 4),
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

              // Search bar
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textPrimary,
                        size: AppDimensions.iconM,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingM),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textLight,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.textLight,
                              size: AppDimensions.iconS,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingM,
                              vertical: AppDimensions.paddingS,
                            ),
                          ),
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingM),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel', style: AppTextStyles.buttonSecondary),
                    ),
                  ],
                ),
              ),

              // Search results header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Results for: ${widget.query}',
                        style: AppTextStyles.heading2),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.paddingM),

              // Filter tabs
              Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = _selectedFilterIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: AppDimensions.paddingS),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingM,
                          vertical: AppDimensions.paddingS,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.borderLight,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              filter['label'],
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isSelected ? AppColors.textWhite : AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: AppDimensions.paddingXS),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.textWhite.withOpacity(0.2)
                                    : AppColors.textLight.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${filter['count']}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected ? AppColors.textWhite : AppColors.textLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppDimensions.paddingM),

              // Results list (static for now)
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
                  children: [
                    SearchResultCard(
                      imageUrl: AppAssets.toriiGate,
                      title: 'Experience the Serenity of Japan\'s Traditional...',
                      author: 'Matthew Berge',
                      date: 'Apr 17, 2023',
                      onTap: () {},
                    ),
                    const SizedBox(height: AppDimensions.paddingM),
                    SearchResultCard(
                      imageUrl: AppAssets.mountain,
                      title: 'Experience vs. Education: What Matters More in...',
                      author: 'Robin Johnson',
                      date: 'Apr 20, 2023',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
