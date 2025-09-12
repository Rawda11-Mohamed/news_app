import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_assets.dart';
import '../cubits/location/location_cubit.dart';
import '../cubits/location/location_state.dart';
import 'search_results_screen.dart';
import 'map_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit()..getLocation(),
      child: Scaffold(
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

                // Search header
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: AppDimensions.iconS,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingM),
                      Text(
                        'Ahmed Saber',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Map section
                Expanded(
                  child: BlocConsumer<LocationCubit, LocationState>(
                    listener: (context, state) {
                      if (state is LocationError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LocationLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is LocationSuccess) {
                        return Container(
                          margin: const EdgeInsets.all(AppDimensions.paddingM),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowLight,
                                blurRadius: AppDimensions.elevationM,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                            child: Stack(
                              children: [
                                GoogleMap(
                                  polylines: {
                                    Polyline(
                                        polylineId: PolylineId('1'),
                                        points: [
                                          LatLng(state.latLng.latitude, state.latLng.longitude),
                                          LatLng(state.latLng.latitude+0.2, state.latLng.longitude+0.2),
                                        ]
                                    )
                                  },
                                  onTap: context.read<LocationCubit>().changeLocation,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(state.latLng.latitude, state.latLng.longitude),
                                    zoom: 5,
                                  ),
                                  myLocationEnabled: true,
                                  markers: context.read<LocationCubit>().markers,
                                ),
                                Positioned(
                                  bottom: AppDimensions.paddingL,
                                  left: AppDimensions.paddingL,
                                  right: AppDimensions.paddingL,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: AppDimensions.buttonHeight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SearchResultsScreen(query: 'location_search',),
                                          ),
                                        );
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
                                        'Get Started',
                                        style: AppTextStyles.buttonPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Center(child: Text('Press the button to get your location'));
                    },
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

