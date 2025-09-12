class Weather {
  final String city;
  final String country;
  final double temperature;
  final String condition;
  final double feelsLike;
  final double fahrenheit;
  final String pressure;
  final double uvIndex;
  final int humidity;
  final String iconCode;
  final double? latitude;
  final double? longitude;

  const Weather({
    required this.city,
    required this.country,
    required this.temperature,
    required this.condition,
    required this.feelsLike,
    required this.fahrenheit,
    required this.pressure,
    required this.uvIndex,
    required this.humidity,
    required this.iconCode,
    this.latitude,
    this.longitude,
  });

  Weather copyWith({
    String? city,
    String? country,
    double? temperature,
    String? condition,
    double? feelsLike,
    double? fahrenheit,
    String? pressure,
    double? uvIndex,
    int? humidity,
    String? iconCode,
    double? latitude,
    double? longitude,
  }) {
    return Weather(
      city: city ?? this.city,
      country: country ?? this.country,
      temperature: temperature ?? this.temperature,
      condition: condition ?? this.condition,
      feelsLike: feelsLike ?? this.feelsLike,
      fahrenheit: fahrenheit ?? this.fahrenheit,
      pressure: pressure ?? this.pressure,
      uvIndex: uvIndex ?? this.uvIndex,
      humidity: humidity ?? this.humidity,
      iconCode: iconCode ?? this.iconCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
      'temperature': temperature,
      'condition': condition,
      'feelsLike': feelsLike,
      'fahrenheit': fahrenheit,
      'pressure': pressure,
      'uvIndex': uvIndex,
      'humidity': humidity,
      'iconCode': iconCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      temperature: (json['temperature'] ?? 0).toDouble(),
      condition: json['condition'] ?? '',
      feelsLike: (json['feelsLike'] ?? 0).toDouble(),
      fahrenheit: (json['fahrenheit'] ?? 0).toDouble(),
      pressure: json['pressure'] ?? '',
      uvIndex: (json["uvIndex"] ?? 0).toDouble(),
      humidity: json["humidity"] ?? 0,
      iconCode: json["iconCode"] ?? "",
      latitude: (json["latitude"])?.toDouble(),
      longitude: (json["longitude"])?.toDouble(),
    );
  }


}