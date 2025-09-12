import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/weather_repository.dart';
import '../../models/weather.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather({double? latitude, double? longitude}) async {
    try {
      emit(WeatherLoading());
      final weather = await _weatherRepository.getCurrentWeather(latitude: latitude, longitude: longitude);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> changeLocation(double latitude, double longitude) async {
    try {
      emit(WeatherLoading());
      final weather = await _weatherRepository.getCurrentWeather(latitude: latitude, longitude: longitude);
      await _weatherRepository.saveLastLocation(weather.city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  void refreshWeather() {
    if (state is WeatherLoaded) {
      final currentWeather = (state as WeatherLoaded).weather;
      getWeather(latitude: currentWeather.latitude, longitude: currentWeather.longitude);
    } else {
      getWeather();
    }
  }
}

