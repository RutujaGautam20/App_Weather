import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecasting/controller/weather_controller.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  @override
  void initState() {
    super.initState();

    Provider.of<WeatherProvider>(context, listen: false)
        .fetchCurrencyExchangeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Exchange',
          style: TextStyle(
              fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          return ListView.builder(
            itemCount: weatherProvider.currencyExchangeData.length,
            itemBuilder: (context, index) {
              var currencyModel = weatherProvider.currencyExchangeData[index];
              return ListTile(
                title: Text(
                  'Currency: ${currencyModel.baseCode}',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Provider: ${currencyModel.provider}',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                    Text(
                      'Documentation: ${currencyModel.documentation}',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
