import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:exhange_rates_flutter/functions/apiCalls.dart';
import 'package:exhange_rates_flutter/models/ratesmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../components/conversionCard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Initial Variables

  late Future<RatesModel> currentRates;
  late Future<Map> currenciesList;
  final formkey = GlobalKey<FormState>();
  bool hasInternetConnection = false;

  //Getting RatesModel and All Currencies
  @override
  void initState() {
    super.initState();
    setState(() {
      currentRates = getRates();
      currenciesList = getCurrencies();
      checkConnectivity();
    });
  }

  Future<void> checkConnectivity() async {
    // Call the checkConnectivity function asynchronously
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        hasInternetConnection = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Currency Conversion App'),
          centerTitle: true,
        ),
        backgroundColor: Colors.amber,
        //Future Builder for Getting Exchange Rates
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(),
              SizedBox(
                height: 10,
              ),
              Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: FutureBuilder<RatesModel>(
                      future: currentRates,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text(
                                  'Please check your Internet Connection'));
                        }

                        if (snapshot.data == null) {
                          return Center(child: Text('Could Make Api Call'));
                        }
                        return Center(
                          child: FutureBuilder<Map>(
                            future: currenciesList,
                            builder: (context, currSnapshot) {
                              if (currSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (currSnapshot.hasError) {
                                return Center(
                                    child: Text(
                                        'Please check your Internet Connection'));
                              }

                              if (currSnapshot.data == null) {
                                return Center(
                                    child: Text('Could Make Api Call'));
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ConversionCard(
                                    currencies: currSnapshot.data!,
                                    rates: snapshot.data!.rates,
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: hasInternetConnection,
                child: Container(
                  child: Lottie.network(
                      'https://lottie.host/aa95decc-bb47-4f28-82c8-8c5201aa48e9/sRxVLg1zTb.json'),
                ),
              ),
            ],
          ),
        ));
  }
}
