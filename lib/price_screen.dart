import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' ;
//ios based widgets used in ios devices
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = 'USD';
  String value = '?';
  CoinData coinData = CoinData();
  List<Widget> listOfCoversions = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListOfCoversions();
  }


  CupertinoPicker getIosDropdown(){
    List<Text> cupertinoList = [];
    for(String currency in currenciesList){
      cupertinoList.add(Text(currency));
    }
    // return cupertinoList;
    CupertinoPicker menu = CupertinoPicker(
        itemExtent: 30,
        onSelectedItemChanged: (index){
          setState(() {
            currentCurrency = currenciesList[index];
            // getData();
            getListOfCoversions();
          }
          );
        }, children: cupertinoList);
    return menu ;
  }

  DropdownButton<dynamic> getAndroidDropdown(){
    List<DropdownMenuItem<String>> currenyListWidget = [];
    for( String currency in currenciesList ){
      DropdownMenuItem<String> item = DropdownMenuItem(
        child: Text(
          currency
      ),
        value: currency,
      );

      currenyListWidget.add(item);
    }
    // return currenyListWidget;
    DropdownButton menu = DropdownButton(
        onChanged: (value){
            setState(() {
            currentCurrency = value.toString() ;
            getListOfCoversions();
            // getData();
            });
            },
            items: currenyListWidget,
            value: currentCurrency,
            );
    return menu;
  }

   void getListOfCoversions() async {
    List<Widget> conversions = [];
    for(String bitcoin in cryptoList ){
      Widget text = await coinData.getText(bitcoin,  currentCurrency);
      conversions.add(text);
    }
    setState(() {
      listOfCoversions = conversions;
    });

  }
  Widget getDeviceDropdown(){

    if(Platform.isAndroid){
      return getAndroidDropdown();
    }else{
      return getIosDropdown();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Column(
                  children:  listOfCoversions ,
                )
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDeviceDropdown()
          ),
        ],
      ),
    );
  }
}


