import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:exhange_rates_flutter/models/allcurrencies.dart';
import 'package:exhange_rates_flutter/models/ratesmodel.dart';
import 'package:exhange_rates_flutter/utils/key.dart';
import 'package:http/http.dart' as http;

//api calls to get the rates and allcurrencies names
Future<RatesModel> getRates() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/latest.json?base=USD&app_id=' + key));
  final result = ratesModelFromJson(response.body);
  return result;
}

Future<Map> getCurrencies() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?app_id=' + key));
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}

//main logic of convert any currency to base currency i.e. USD and then converting to desired ones

String convertany(Map exchangeRates, String amount, String currencybase,
    String currencyfinal) {
  String output = (double.parse(amount) /
          exchangeRates[currencybase] *
          exchangeRates[currencyfinal])
      .toStringAsFixed(2)
      .toString();

  return output;
}

//simple checking internet connection
Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}
