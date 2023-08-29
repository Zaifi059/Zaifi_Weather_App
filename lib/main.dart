import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zaifi Weather App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final apiKey = '158967843a4e4cf212969a5b6480d58c';
  String city = 'Vehari';
  String temperature = '';
  String currentWeather = '';
  String humidity = '';
  List dailyForecastData = [];

  Future<void> _fetchWeatherData() async {
    final geocodingUrl = Uri.parse(
        'https://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$apiKey');
    final geocodingResponse = await http.get(geocodingUrl);
    final geocodingData = json.decode(geocodingResponse.body);
    final lat = geocodingData[0]['lat'];
    final lon = geocodingData[0]['lon'];

    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,hourly,alerts&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      final mainData = weatherData['current'];
      final weather = weatherData['current']['weather'][0]['main'];
      dailyForecastData = weatherData['daily'];

      setState(() {
        temperature = '${mainData['temp']}°C';
        currentWeather = weather;
        humidity = '${mainData['humidity']}%';
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zaifi Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.deepPurpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    city = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter City',
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        city = 'Vehari';
                      });
                      _fetchWeatherData();
                    },
                    child: Text('V'),
                  ),
                  SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        city = 'Multan';
                      });
                      _fetchWeatherData();
                    },
                    child: Text('M'),
                  ),
                  SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        city = 'Lahore';
                      });
                      _fetchWeatherData();
                    },
                    child: Text('L'),
                  ),
                ],
              ),
              SizedBox(height:
              16),
              FloatingActionButton(onPressed:
              _fetchWeatherData, child:
              Icon(Icons.auto_fix_normal_sharp)),
              SizedBox(height:
              16),
              Text('Temperature:',
                  style:
                  TextStyle(fontSize:
                  20)),
              SizedBox(height:
              16),
              Text(temperature,
                  style:
                  TextStyle(fontSize:
                  36, fontWeight:
                  FontWeight.bold)),
              SizedBox(height:
              16),
              Text('Humidity:',
                  style:
                  TextStyle(fontSize:
                  20)),
              SizedBox(height:
              16),
              Text(humidity,
                  style:
                  TextStyle(fontSize:
                  36, fontWeight:
                  FontWeight.bold)),
              SizedBox(height:
              16),
              Text('Daily Forecast:',
                  style:
                  TextStyle(fontSize:
                  20)),
              Expanded(child:
              ListView.builder(itemBuilder:
                  (context, index) {
                final time =
                DateTime.fromMillisecondsSinceEpoch(dailyForecastData[index]['dt'] * 1000);
                final day =
                DateFormat('EEEE').format(time);
                return ListTile(title:
                Row(mainAxisAlignment:
                MainAxisAlignment.center, children:
                [
                  Text(day,
                      style:
                      TextStyle(fontWeight:
                      FontWeight.bold)),
                  SizedBox(width:
                  16),
                  Text('${dailyForecastData[index]['temp']['day']}°C'),
                ]));
              }, itemCount:
              dailyForecastData.length))
            ],
          ),
        ),
      ),
    );
  }
}
