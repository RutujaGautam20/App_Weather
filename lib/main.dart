import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecasting/controller/weather_controller.dart';
import 'package:weather_forecasting/view/currency_page.dart';
import 'package:weather_forecasting/view/home_page.dart';
import 'package:weather_forecasting/view/settings_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: context.watch<WeatherProvider>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
        '/currencyPage': (context) => CurrencyPage(),
      },
    );
  }
}
