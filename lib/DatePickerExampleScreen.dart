import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:intl/intl.dart';

class DatePickerExampleScreen extends StatefulWidget {
  @override
  _DatePickerExampleScreenState createState() =>
      _DatePickerExampleScreenState();
}

class _DatePickerExampleScreenState extends State<DatePickerExampleScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  String formattedStartDate = "";
  String formattedEndDate = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020, 10, 10),
      lastDate: DateTime(2024, 11, 30),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;

        formattedStartDate = _startDate != null
            ? DateFormat('dd-MM-yyyy').format(_startDate!)
            : 'No date selected';
        formattedEndDate = _endDate != null
            ? DateFormat('dd-MM-yyyy').format(_endDate!)
            : 'No date selected';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date Range'),
            ),
            SizedBox(height: 20.0),
            Text(
              _startDate != null && _endDate != null
                  ? 'Selected Date Range: ${formattedStartDate} - ${formattedEndDate}'
                  : 'No date selected',
            ),
          ],
        ),
      ),
    );
  }
}
