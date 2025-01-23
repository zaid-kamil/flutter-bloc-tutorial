part of 'weather_bloc.dart';

@immutable // immutable means that the class cannot be changed after it has been created
sealed class WeatherEvent {}

class RequestEvent extends WeatherEvent {
  // what to receive from the ui
  final String cityName;

  // constructor
  RequestEvent(this.cityName);
}

class ResetEvent extends WeatherEvent {}
