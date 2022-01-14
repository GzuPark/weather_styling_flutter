import 'package:flutter/material.dart';
import 'package:weather_styling_flutter/data/weather.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  List<LocationData> locations = [
    LocationData(name: '강남구', x: 0, y: 0, lat: 37.498122, lon: 127.027565),
    LocationData(name: '동작구', x: 1, y: 1, lat: 37.502418, lon: 127.953647),
    LocationData(name: '마포구', x: 2, y: 2, lat: 37.560502, lon: 127.907612),
    LocationData(name: '성동구', x: 3, y: 3, lat: 37.556723, lon: 127.035401),
    LocationData(name: '강동구', x: 4, y: 4, lat: 37.552288, lon: 127.145225),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: List.generate(locations.length, (idx) {
          return ListTile(
            title: Text(locations[idx].name),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).pop(locations[idx]);
            },
          );
        }),
      ),
    );
  }
}
