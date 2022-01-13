import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_styling_flutter/data/api.dart';

import 'data/weather.dart';

void main() async {
  await dotenv.load(fileName: 'assets/env/.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final api = WeatherApi();
          List<Weather> weather = await api.getWeather(1, 1, 20220113, '1830');

          for (final w in weather) {
            print(w.date);
            print(w.time);
            print(w.t1h);
          }
        },
      ),
    );
  }
}
