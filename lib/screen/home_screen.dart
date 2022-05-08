import 'package:flutter/material.dart';
import 'package:learn_flutter/model/location.dart';
import 'package:learn_flutter/model/quote.dart';
import 'package:learn_flutter/model/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const API_KEY = "753a60160eeecc5d4fc6473491896a32";

class _HomeScreenState extends State<HomeScreen> {
  late double _lat;
  late double _long;
  late String _quote;
  late String _author;

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  void getQuote() {
    Quote quote = Quote();
    quote.getQuote();
    setState(() {
      _quote = quote.quote;
      _author = quote.author;
    });
  }

  Future<Weather> getWeather() async {
    Location location = Location();
    await location.getLocation();
    _lat = location.latitude;
    _long = location.longitude;
    Uri url = Uri.https("api.openweathermap.org", "/data/2.5/weather",
        {"lat": "$_lat", "lon": '$_long', "appid": API_KEY, "units": "metric"});

    Weather weather = Weather(url);
    await weather.getWeather();

    return weather;
  }

  @override
  Widget build(BuildContext context) {
    Widget _todayWeatherInfo(Weather weather) {
      return Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(weather.weather), Text(weather.city)],
            ),
          ));
    }

    Widget _errorView(String errorMessage) {
      return Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(errorMessage),
            ],
          )));
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FutureBuilder<Weather>(
              future: getWeather(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _todayWeatherInfo(snapshot.data!);
                } else if (snapshot.hasError) {
                  return _errorView(snapshot.error.toString());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            Text('quote: $_quote'),
            Text('author: $_author'),
            FloatingActionButton(
              onPressed: getQuote,
              tooltip: 'new quote',
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
