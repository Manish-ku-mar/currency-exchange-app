import 'package:exhange_rates_flutter/functions/apiCalls.dart';
import 'package:flutter/material.dart';

class ConversionCard extends StatefulWidget {
  final rates;
  final Map currencies;
  const ConversionCard(
      {Key? key, @required this.rates, required this.currencies})
      : super(key: key);

  @override
  _ConversionCardState createState() => _ConversionCardState();
}

class _ConversionCardState extends State<ConversionCard> {
  TextEditingController amountController = TextEditingController();

  String currencyFromValue = 'AUD';
  String currencyToValue = 'AUD';
  String answer = 'Convert curriency will be shown below!! Enjoy :)';

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Convert Any Currency',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 20),

            //TextFields for Entering USD
            TextFormField(
              key: ValueKey('amount'),
              controller: amountController,
              decoration: InputDecoration(hintText: 'Enter the Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: currencyFromValue,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        currencyFromValue = newValue!;
                      });
                    },
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('To')),
                Expanded(
                  child: DropdownButton<String>(
                    value: currencyToValue,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        currencyToValue = newValue!;
                      });
                    },
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    answer = amountController.text +
                        ' ' +
                        currencyFromValue +
                        ' equals to ' +
                        convertany(widget.rates, amountController.text,
                            currencyFromValue, currencyToValue) +
                        ' ' +
                        currencyToValue;
                  });
                },
                child: Text('Convert'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(height: 10),
            Container(child: Text(answer))
          ],
        ),
      ),
    );
  }
}
