class Weather {
  String category;
  String date;
  int time;
  int value;

  Weather({
    required this.category,
    required this.date,
    required this.time,
    required this.value,
  });

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
      category: data['category'],
      date: data['fastDate'],
      time: int.tryParse(data['fcstTime'] ?? '') ?? 0,
      value: int.tryParse(data['fcstValue'] ?? '') ?? 0,
    );
  }
}
