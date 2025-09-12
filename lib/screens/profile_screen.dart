import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';
import '../widgets/weather_card.dart';
import '../cubits/weather/weather_cubit.dart';
import '../cubits/weather/weather_state.dart';
import '../cubits/location/location_cubit.dart';
import '../cubits/location/location_state.dart';
import 'map_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocationCubit>().getLocation();
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
                      ),]
                    ),
                  ),
                
                const SizedBox(height: AppDimensions.paddingM),
                
                // Greeting section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,',
                          style: AppTextStyles.greeting,
                        ),
                        Text(
                          'Ahmed Saber',
                          style: AppTextStyles.greetingName,
                        ),
                        const SizedBox(height: AppDimensions.paddingXS),
                        Text(
                          'Sun 9 April, 2023',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    Row(
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
                    ),
                  ],
                ),
                
                const SizedBox(height: AppDimensions.paddingL),
                
                // Weather card
                BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, weatherState) {
                    if (weatherState is WeatherLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (weatherState is WeatherLoaded) {
                      return WeatherCard(
                          city: weatherState.weather.city,
                          temperature: weatherState.weather.temperature.toString(),
                    condition: weatherState.weather.condition,
                    feelsLike: weatherState.weather.feelsLike.toString(),
                    fahrenheit: weatherState.weather.fahrenheit.toString(),
                    pressure: weatherState.weather.pressure.toString(),
                    uvIndex: weatherState.weather.uvIndex.toString(),
                    humidity: weatherState.weather.humidity.toString(),

                    onChangeLocation: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MapScreen(),
                            ),
                          );
                        },
                      );
                    }
                    if (weatherState is WeatherError) {
                      return Center(
                        child: Column(
                          children: [
                            Text(
                              'Error loading weather: ${weatherState.message}',
                              style: AppTextStyles.bodyMedium,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<WeatherCubit>().getWeather();
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                
                const SizedBox(height: AppDimensions.paddingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

