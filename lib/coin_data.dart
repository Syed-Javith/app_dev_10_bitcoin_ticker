import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants/constants.dart';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<String> getData(String bitcoin , String currentCurrency) async{
    String url = kUrl + bitcoin + '/' + currentCurrency + kApikey;
    http.Response response = await http.get(Uri.parse(url));
      // value = jsonDecode(response.body)['rate'].toStringAsFixed(0);
      // print(value);
    print(response.body);
    return jsonDecode(response.body)['rate'].toStringAsFixed(0);
  }

  Future<Widget> getText(String bitcoin , String currentCurrency) async {
    String value = await getData(bitcoin,currentCurrency);
    return Text(
      '1 $bitcoin = $value $currentCurrency',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
  }

}
