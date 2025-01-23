import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_flutter_bloc_tutorial/weather_feature/pages/weather_page.dart';
import 'package:sm_flutter_bloc_tutorial/weather_feature/weather_bloc.dart';

void main() {
  runApp(const MyBlockApp());
}

class MyBlockApp extends StatelessWidget {
  const MyBlockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        home: const WeatherPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
