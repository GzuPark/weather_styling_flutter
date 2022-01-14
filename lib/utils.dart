import 'dart:math' as math;

class Utils {
  static String makeTwoDigit(int number) {
    return number.toString().padLeft(2, '0');
  }

  static int getFormatTime(DateTime time) {
    return int.parse('${time.year}${makeTwoDigit(time.month)}${makeTwoDigit(time.day)}');
  }

  static DateTime stringToDateTime(String date) {
    int year = int.parse(date.substring(0, 4));
    int month = int.parse(date.substring(4, 6));
    int day = int.parse(date.substring(6, 8));

    return DateTime(year, month, day);
  }

  static Map<String, int> latLngToXY(double v1, double v2) {
    const double re = 6371.00877; // 지구 반경(km)
    const double grid = 5.0; // 격자 간격(km)
    const double slat1 = 30.0; // 투영 위도1(degree)
    const double slat2 = 60.0; // 투영 위도2(degree)
    const double oLon = 126.0; // 기준점 경도(degree)
    const double oLat = 38.0; // 기준점 위도(degree)
    const double xo = 43; // 기준점 X좌표(grid)
    const double yo = 136; // 기1준점 Y좌표(grid)

    var degRad = math.pi / 180.0;
// var radDeg = 180.0 / math.pi;

    var _re = re / grid;
    var _slat1 = slat1 * degRad;
    var _slat2 = slat2 * degRad;
    var _oLon = oLon * degRad;
    var _oLat = oLat * degRad;

    var _sn = math.tan(math.pi * 0.25 + _slat2 * 0.5) / math.tan(math.pi * 0.25 + _slat1 * 0.5);
    _sn = math.log(math.cos(_slat1) / math.cos(_slat2)) / math.log(_sn);

    var _sf = math.tan(math.pi * 0.25 + _slat1 * 0.5);
    _sf = math.pow(_sf, _sn) * math.cos(_slat1) / _sn;

    var _ro = math.tan(math.pi * 0.25 + _oLat * 0.5);
    _ro = _re * _sf / math.pow(_ro, _sn);

    Map<String, int> rs = {};
    var _ra = math.tan(math.pi * 0.25 + (v1) * degRad * 0.5);
    _ra = _re * _sf / math.pow(_ra, _sn);

    var theta = v2 * degRad - _oLon;
    if (theta > math.pi) theta -= 2.0 * math.pi;
    if (theta < -math.pi) theta += 2.0 * math.pi;
    theta *= _sn;

    rs['nx'] = (_ra * math.sin(theta) + xo + 0.5).floor().toInt();
    rs['ny'] = (_ro - _ra * math.cos(theta) + yo + 0.5).floor().toInt();

    return rs;
  }
}
