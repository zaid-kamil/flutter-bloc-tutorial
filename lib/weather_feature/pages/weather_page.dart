import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_flutter_bloc_tutorial/weather_feature/data/weather.dart';
import 'package:sm_flutter_bloc_tutorial/weather_feature/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController cityController = TextEditingController();

  void onGetWeather() {
    String city = cityController.text;
    debugPrint("City: $city");
    if (city.isEmpty) {
      return;
    }
    BlocProvider.of<WeatherBloc>(context).add(RequestEvent(city));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: "Enter city name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    onGetWeather();
                  },
                  child: Text("Get Weather"),
                ),
                ElevatedButton(
                  onPressed: () => {
                    BlocProvider.of<WeatherBloc>(context).add(
                      ResetEvent(),
                    ),
                  },
                  child: Text("Reset"),
                ),
              ],
            ),
            BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if (state is WeatherError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return CircularProgressIndicator();
                } else if (state is WeatherSuccess) {
                  return WeatherUI(weather: state.weather);
                } else if (state is WeatherError) {
                  return ErrorUI(message: state.message);
                } else {
                  return WeatherUI(weather: null);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherUI extends StatelessWidget {
  final Weather? weather;

  const WeatherUI({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // weather.weatherCondition can be sunny or cloudy or raining, etc.
        // switch case to display image
        if (weather?.weatherCondition == "sunny")
          Image.asset("assets/images/sunny.png"),
        if (weather?.weatherCondition == "cloudy")
          Image.asset("assets/images/cloud.png"),
        SizedBox(
          height: 20,
        ),
        Text(
          weather?.city ?? "Select City",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          weather?.temperature ?? "N/A",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}

class ErrorUI extends StatelessWidget {
  final String message;

  const ErrorUI({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.error,
          size: 100,
          color: Colors.red,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
