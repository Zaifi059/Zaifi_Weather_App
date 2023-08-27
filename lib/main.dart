import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherApp());

}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Zaifi Weather App',
      theme: ThemeData(
        backgroundColor: Colors.white12,
        primarySwatch: Colors.deepPurple,
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
  String city = '';
  String temperature = '';

  Future<void> _fetchWeatherData() async {
    final url =
    Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      final mainData = weatherData['main'];
      setState(() {
        temperature = '${mainData['temp']}°C';
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
      body: Center(
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
            ElevatedButton(
              onPressed: () {
                _fetchWeatherData();
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 16),
            Text(
              'Temperature:',
              style: TextStyle(fontSize: 20),
              selectionColor: Colors.redAccent,

            ),
            SizedBox(height: 16),
            Text(
              temperature,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}