import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecasting/controller/weather_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<WeatherProvider>(context, listen: false).fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(
              fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            splashRadius: 20,
            color: weatherProvider.isDarkMode ? Colors.white : Colors.black,
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          IconButton(
            icon: Icon(Icons.attach_money),
            splashRadius: 20,
            color: weatherProvider.isDarkMode ? Colors.white : Colors.black,
            onPressed: () {
              Navigator.pushNamed(context, '/currencyPage');
            },
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          return weatherProvider.weatherData.isEmpty
              ? Center(
                  child: Text(
                    'No weather data available',
                    style: TextStyle(fontFamily: 'PlayfairDisplay'),
                  ),
                )
              : ListView.builder(
                  itemCount: weatherProvider.weatherData.length,
                  itemBuilder: (context, index) {
                    final weatherData = weatherProvider.weatherData[index];
                    return ListTile(
                      title: Text(
                        weatherData.city,
                        style: TextStyle(fontFamily: 'PlayfairDisplay'),
                      ),
                      subtitle: Text(
                        'Temperature: ${weatherData.temperature.toStringAsFixed(2)}°C\nCondition: ${weatherData.weatherCondition}',
                        style: TextStyle(fontFamily: 'PlayfairDisplay'),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
