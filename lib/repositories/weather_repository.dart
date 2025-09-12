import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather.dart';

class WeatherRepository {
  static const String _lastLocationKey = 'last_weather_location';
  
  // Mock weather data for demonstration
  static final Map<String, Weather> _mockWeatherData = {
    'cairo': Weather(
      city: 'Cairo',
      country: 'EG',
      temperature: 27.0,
      condition: 'Clear - Clear Sky',
      feelsLike: 28.0,
      fahrenheit: 72.0,
      pressure: '134 mp/h',
      uvIndex: 0.2,
      humidity: 48,
      iconCode: 'sunny',
    ),
    'london': Weather(
      city: 'London',
      country: 'UK',
      temperature: 15.0,
      condition: 'Cloudy - Overcast',
      feelsLike: 13.0,
      fahrenheit: 59.0,
      pressure: '120 mp/h',
      uvIndex: 0.1,
      humidity: 65,
      iconCode: 'cloudy',
    ),
    'new york': Weather(
      city: 'New York',
      country: 'US',
      temperature: 22.0,
      condition: 'Partly Cloudy',
      feelsLike: 24.0,
      fahrenheit: 72.0,
      pressure: '128 mp/h',
      uvIndex: 0.3,
      humidity: 55,
      iconCode: 'partly_cloudy',
    ),
    'tokyo': Weather(
      city: 'Tokyo',
      country: 'JP',
      temperature: 18.0,
      condition: 'Rainy - Light Rain',
      feelsLike: 16.0,
      fahrenheit: 64.0,
      pressure: '115 mp/h',
      uvIndex: 0.1,
      humidity: 78,
      iconCode: 'rainy',
    ),
  };

  Future<Weather> getCurrentWeather({double? latitude, double? longitude}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    try {
      String targetCity;
      if (latitude != null && longitude != null) {
        // In a real app, you would use a reverse geocoding service here
        // to get the city name from lat/lng.
        // For now, we'll just pick a city based on a simple check or default.
        if (latitude > 30 && latitude < 31 && longitude > 31 && longitude < 32) {
          targetCity = 'cairo';
        } else if (latitude > 51 && latitude < 52 && longitude > -1 && longitude < 0) {
          targetCity = 'london';
        } else {
          targetCity = 'new york'; // Default for other locations
        }
      } else {
        targetCity = await getLastLocation() ?? 'cairo';
      }
      
      targetCity = targetCity.toLowerCase();
      
      final weather = _mockWeatherData[targetCity];
      if (weather != null) {
        return weather;
      } else {
        // Return default weather if city not found
        return _mockWeatherData['cairo']!;
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }

  Future<void> saveLastLocation(String city) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastLocationKey, city);
    } catch (e) {
      throw Exception('Failed to save location: $e');
    }
  }

  Future<String?> getLastLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_lastLocationKey);
    } catch (e) {
      return null;
    }
  }

  Future<List<String>> getAvailableCities() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockWeatherData.keys.map((key) => 
      _mockWeatherData[key]!.city
    ).toList();
  }

  Future<Weather> getWeatherForecast(String city, int days) async {
    // For demo purposes, return current weather
    // In a real app, this would return forecast data
    return getCurrentWeather();
  }
}

