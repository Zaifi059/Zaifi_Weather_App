import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
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
  bool showDailyForecast = false;

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

  void _toggleDailyForecast() {
    setState(() {
      showDailyForecast = !showDailyForecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      city = value;
                    });
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Enter City',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    prefixIcon:
                    Icon(Icons.location_city, color: Colors.black38),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        city = 'Vehari';
                      });
                      _fetchWeatherData();
                    },
                    child: Text('Vehari'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        city = 'Multan';
                      });
                      _fetchWeatherData();
                    },
                    child: Text('Multan'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        city = 'Lahore';
                      });
                      _fetchWeatherData();
                    },
                    child: Text('Lahore'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              FloatingActionButton(
                onPressed: () {
                  _fetchWeatherData();
                },
                child: Icon(Icons.search, color: Colors.black38),
              ),
              SizedBox(height: 16),
              Text(city, style: TextStyle(fontSize: 24, color: Colors.black)),
              SizedBox(height: 16),
              Text(temperature, style: TextStyle(fontSize: 40, color: Colors.black)),
              SizedBox(height: 16),
              Text(currentWeather, style: TextStyle(fontSize: 24, color: Colors.black)),
              SizedBox(height: 16),
              Text('Humidity:', style: TextStyle(fontSize: 24, color: Colors.black)),
              Text(humidity, style: TextStyle(fontSize: 40, color: Colors.black)),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _toggleDailyForecast,
                child: Text(showDailyForecast ? 'Hide Daily Forecast' : 'Show Daily Forecast'),
              ),
              if (showDailyForecast)
                Expanded(
                  child: ListView.builder(
                    itemCount: dailyForecastData.length,
                    itemBuilder: (context, index) {
                      final dayData = dailyForecastData[index];
                      final temp = dayData['temp']['day'].toStringAsFixed(1);
                      final date = DateTime.fromMillisecondsSinceEpoch(dayData['dt'] * 1000);
                      final formattedDate = '${date.day}/${date.month}/${date.year}';
                      final weather = dayData['weather'][0]['main'];

                      return ListTile(
                        title: Text(formattedDate),
                        subtitle: Text(weather),
                        trailing: Text('$temp°C'),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
