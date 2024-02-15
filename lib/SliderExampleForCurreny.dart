import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SliderExample extends StatefulWidget {
  @override
  _SliderExampleState createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _sliderValue = 0.0;
  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

  double calculateTotalValue(double sliderValue) {
    // Example logic: Double the slider value
    return sliderValue * 2 / 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Slider Value: ${currencyFormatter.format(_sliderValue)}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Slider(
                value: _sliderValue,
                min: 0.0,
                max: 100000.0, // 1 lakh
                divisions: 100,
                onChanged: (newValue) {
                  setState(() {
                    _sliderValue = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Total Value: ${currencyFormatter.format(calculateTotalValue(_sliderValue))}',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
