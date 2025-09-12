import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final String temperature;
  final String condition;
  final String feelsLike;
  final String fahrenheit;
  final String pressure;
  final String uvIndex;
  final String humidity;
  final VoidCallback onChangeLocation;

  const WeatherCard({
    Key? key,
    required this.city,
    required this.temperature,
    required this.condition,
    required this.feelsLike,
    required this.fahrenheit,
    required this.pressure,
    required this.uvIndex,
    required this.humidity,
    required this.onChangeLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.weatherCardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: AppDimensions.elevationM,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location and temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: AppTextStyles.weatherLocation,
                  ),
                  const SizedBox(height: AppDimensions.paddingXS),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        temperature,
                        style: AppTextStyles.weatherTemperature,
                      ),
                      Text(
                        '°',
                        style: AppTextStyles.weatherTemperature.copyWith(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Weather icon
              Container(
                width: AppDimensions.weatherIconSize,
                height: AppDimensions.weatherIconSize,
                decoration: BoxDecoration(
                  color: AppColors.weatherIconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  Icons.wb_sunny,
                  color: AppColors.weatherIconColor,
                  size: 40,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppDimensions.paddingS),
          
          // Condition and feels like
          Text(
            condition,
            style: AppTextStyles.weatherCondition,
          ),
          Text(
            feelsLike,
            style: AppTextStyles.weatherCondition,
          ),
          
          const SizedBox(height: AppDimensions.paddingL),
          
          // Weather details
          Row(
            children: [
              Expanded(
                child: _buildWeatherDetail(
                  Icons.thermostat,
                  fahrenheit,
                  'Fahrenheit',
                ),
              ),
              Expanded(
                child: _buildWeatherDetail(
                  Icons.air,
                  pressure,
                  'Pressure',
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppDimensions.paddingM),
          
          Row(
            children: [
              Expanded(
                child: _buildWeatherDetail(
                  Icons.wb_sunny_outlined,
                  uvIndex,
                  'UV Index',
                ),
              ),
              Expanded(
                child: _buildWeatherDetail(
                  Icons.water_drop,
                  humidity,
                  'Humidity',
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppDimensions.paddingL),
          
          // Change location button
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: onChangeLocation,
              icon: const Icon(
                Icons.location_on,
                size: AppDimensions.iconS,
              ),
              label: Text(
                'Change Location',
                style: AppTextStyles.buttonPrimary,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonPrimary,
                foregroundColor: AppColors.textWhite,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(IconData icon, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: AppDimensions.iconS,
            ),
            const SizedBox(width: AppDimensions.paddingXS),
            Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingXS),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            label,
            style: AppTextStyles.bodySmall,
          ),
        ),
      ],
    );
  }
}

