import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather {
  final Uri _url;
  Weather(this._url);

  late String city;
  late String weather;

  Future<void> getWeather() async {
    http.Response response = await http.get(_url);
    if (response.statusCode == 200) {
      String body = response.body;
      dynamic data = jsonDecode(body);
      city = data['name'];
      weather = data['weather'][0]['main'] + '/' + '${data['main']['temp']}';
    }
  }
}
