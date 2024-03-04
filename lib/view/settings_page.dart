import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecasting/controller/weather_controller.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
              fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Theme Settings',
              style: TextStyle(fontFamily: 'PlayfairDisplay'),
            ),
            Switch(
              activeColor: Colors.indigo,
              value: context.watch<WeatherProvider>().isDarkMode,
              onChanged: (value) {
                context.read<WeatherProvider>().toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
