// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      city: json['city'] as String,
      temperature: json['temperature'] as String,
      weatherCondition: json['weatherCondition'] as String,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'city': instance.city,
      'temperature': instance.temperature,
      'weatherCondition': instance.weatherCondition,
    };
