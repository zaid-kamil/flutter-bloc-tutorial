import 'dart:convert';

import 'package:http/http.dart';
import 'package:sm_flutter_bloc_tutorial/weather_feature/data/weather_data_provider.dart';

import 'weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String cityName);
}

// fake impl
class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> getWeather(String cityName) async {
    await Future.delayed(Duration(seconds: 3));
    return Weather(
      city: cityName,
      temperature: '27°C',
      weatherCondition: 'Cloudy',
    );
  }
}

// real impl can be done inside domain directory
class ApiWeatherRepository implements WeatherRepository {
  final WeatherDataProvider weatherDataProvider = WeatherDataProvider();

  @override
  Future<Weather> getWeather(String cityName) async {
    final Response rawWeather =
        await weatherDataProvider.getRawWeatherData(cityName);
    final json = await jsonDecode(rawWeather.body);
    final Weather weather = Weather.fromJson(json);
    return weather;
  }
}
