import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_forecasting/model/currency_model.dart';
import 'package:weather_forecasting/model/weather_model.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class WeatherProvider extends ChangeNotifier {
  TextStyle cityTextStyle = TextStyle(fontFamily: 'PlayfairDisplay');

  List<WeatherModel> _weatherData = [];
  List<WeatherModel> get weatherData => _weatherData;

  List<CurrencyModel> _currencyExchangeData = [];
  List<CurrencyModel> get currencyExchangeData => _currencyExchangeData;

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Future<bool> _isConnected() async {
    return await InternetConnectionChecker().hasConnection;
  }

  void showNetworkStatusSnackBar(String message) {
    final navigatorState = navigatorKey.currentState;

    if (navigatorState != null) {
      final snackBar = SnackBar(
        content: Text(message),
        duration: Duration(seconds: 8),
      );
      ScaffoldMessenger.of(navigatorState.overlay!.context)
          .showSnackBar(snackBar);
    } else {
      print('Error: navigatorKey.currentState is null');
    }
  }

  Future<void> fetchWeatherData() async {
    try {
      bool isConnected = await _isConnected();

      if (!isConnected) {
        print('No internet Connection');
        showNetworkStatusSnackBar('No internet Connection');
        return;
      }

      if (isConnected) {
        final apiKey = '44d343d6cfd8eec32690eab72d143918';
        final cities = [
          'New York',
          'Tokyo',
          'London',
          'Barcelona',
          'Madrid',
          'Seville'
        ];

        List<WeatherModel> weatherDataList = [];

        for (var city in cities) {
          final apiUrl =
              'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

          final response = await http.get(Uri.parse(apiUrl));

          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final weatherData = WeatherModel.fromJson(data);

            weatherDataList.add(weatherData);
          } else {
            print(
                'Failed to fetch data for $city. Status code: ${response.statusCode}');
          }

          _weatherData = weatherDataList;
          notifyListeners();
        }
      }
    } catch (error) {
      print('Error during data fetching: $error');
    }
  }

  Future<void> fetchCurrencyExchangeData() async {
    try {
      final currencyApiKey = 'f7c21dcb33303e4e78416839';
      final currencies = ['USD', 'EUR', 'JPY', 'GBP', 'AUD', 'CAD'];

      for (var currency in currencies) {
        final currencyApiUrl =
            'https://open.er-api.com/v6/latest/$currency?apikey=$currencyApiKey';

        final currencyResponse = await http.get(Uri.parse(currencyApiUrl));

        if (currencyResponse.statusCode == 200) {
          final currencyData = CurrencyModel.fromJson(
            currency,
            json.decode(currencyResponse.body),
          );
          _currencyExchangeData.add(currencyData);
        } else {
          print(
              'Failed to fetch currency exchange rates for $currency. Status code: ${currencyResponse.statusCode}');
        }
      }
      notifyListeners();
    } catch (error) {
      print('Error during currency exchange rates fetching: $error');
    }
  }
}
