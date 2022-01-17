class Weather {
  String date;
  int time;
  int rn1; // 1시간 강수량
  int pty; // 강수형태
  int sky; // 하늘상태
  int t1h; // 기온
  int reh; // 습도
  double wsd; // 풍속

  Weather({
    required this.date,
    required this.time,
    required this.rn1,
    required this.pty,
    required this.sky,
    required this.t1h,
    required this.reh,
    required this.wsd,
  });

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
      date: data['fcstDate'],
      time: int.tryParse(data['fcstTime'] ?? '') ?? 0,
      rn1: int.tryParse(data['RN1'] ?? '') ?? 0,
      pty: int.tryParse(data['PTY'] ?? '') ?? 0,
      sky: int.tryParse(data['SKY'] ?? '') ?? 0,
      t1h: int.tryParse(data['T1H'] ?? '') ?? 0,
      reh: int.tryParse(data['REH'] ?? '') ?? 0,
      wsd: double.tryParse(data['WSD'] ?? '') ?? 0,
    );
  }
}

class LocationData {
  String name;
  int? x;
  int? y;
  double lat;
  double lon;

  LocationData({
    required this.name,
    this.x,
    this.y,
    required this.lat,
    required this.lon,
  });
}

class ClothTemperature {
  int temperature;
  List<String> cloth;

  ClothTemperature({
    required this.temperature,
    required this.cloth,
  });
}
