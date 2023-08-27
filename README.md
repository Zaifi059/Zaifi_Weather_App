# Zaifi Weather App


The Zaifi Weather App is a simple Flutter application that allows users to check the current temperature and view a forecast graph for the next three hours based on the OpenWeatherMap API.

## Features

- **Current Temperature**: Display the current temperature and weather conditions for a given city.
- **Quick City Selection**: Easily switch between predefined cities (Vehari, Multan, Lahore) to view their weather data.
- **Real-time Updates**: Fetches and displays the latest weather data using the OpenWeatherMap API.
- **Forecast Graph**: Visualize the forecasted temperatures for the next three hours in an interactive line chart.
- **User-friendly Interface**: Intuitive user interface with a clean and appealing design.

## Getting Started

1. Clone this repository to your local machine.
2. Open the project in your preferred IDE.
3. Ensure you have Flutter and Dart SDK installed on your machine.
4. Install dependencies with `flutter pub get`.
5. Replace `'YOUR_API_KEY'` in `_WeatherPageState` with your actual OpenWeatherMap API key.
6. Run the app with `flutter run`.

## Dependencies

- [fl_chart](https://pub.dev/packages/fl_chart): Used to display the forecast temperature graph.
- [http](https://pub.dev/packages/http): Used for HTTP requests to OpenWeatherMap API.

## API Key

Obtain an API key from OpenWeatherMap and replace `158967843a4e4cf212969a5b6480d58c` in the code.

## Contributing

Contributions are welcome! Open issues or submit pull requests.

## License

Licensed under the MIT License -  [LICENSE](LICENSE) .
