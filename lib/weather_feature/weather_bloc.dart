import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_flutter_bloc_tutorial/weather_feature/data/weather_repo.dart';

import 'data/weather.dart';

part 'weather_event.dart'; // means that this file is a part of the weather_bloc.dart file
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // fake repository for demonstration
  final _weatherRepository = FakeWeatherRepository();

  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      switch (event) {
        case RequestEvent():
          emit(WeatherLoading());
          try {
            final weatherResponse =
                await _weatherRepository.getWeather(event.cityName);
            emit(WeatherSuccess(weatherResponse));
          } on Exception catch (e) {
            emit(WeatherError(e.toString()));
          }
        case ResetEvent():
          emit(WeatherInitial());
      }
    });
  }
}
