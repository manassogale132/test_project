import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class ExpansionTileExampleScreen extends StatefulWidget {
  const ExpansionTileExampleScreen({super.key});

  @override
  State<ExpansionTileExampleScreen> createState() =>
      _ExpansionTileExampleScreenState();
}

class _ExpansionTileExampleScreenState
    extends State<ExpansionTileExampleScreen> {
  String foos = 'One';
  String selecetd = 'One';
  int _key = 0;

  _collapse() {
    int newKey = 0;
    do {
      _key = new Random().nextInt(10000);
    } while (newKey == _key);
  }

  @override
  void initState() {
    super.initState();
    _collapse();
  }

  List<String> dropDownList = ["One", "Two", "Three"];

  //date values for range
  DateTime? _startDate;
  DateTime? _endDate;
  String formattedStartDate = "";
  String formattedEndDate = "";

  //single date selected
  DateTime? _startDateSingle;
  String formattedStartDateSingle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('ExpansionTile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(14),
                  // Adjust the value as needed
                  border: Border.all(
                    color: Colors.black54, // Set border color here
                    width: 0.5, // Set border width here
                  ),
                ),
                child: new ExpansionTile(
                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color: Colors.grey.shade400),
                    borderRadius: new BorderRadius.all(
                      new Radius.circular(14),
                    ),
                  ),
                  key: new Key(
                    _key.toString(),
                  ),
                  initiallyExpanded: false,
                  title: new Text(
                    this.foos,
                  ),
                  backgroundColor: Colors.white,
                  children: List.generate(
                    dropDownList.length,
                    (index) {
                      if (index == dropDownList.length - 1) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          color: Colors.white,
                          child: new ListTile(
                            tileColor: Colors.white,
                            title: Text(dropDownList[index]),
                            onTap: () {
                              setState(() {
                                this.foos = dropDownList[index].toString();
                                _collapse();
                              });
                            },
                          ),
                        );
                      }
                      return Container(
                        color: Colors.white,
                        child: new ListTile(
                          tileColor: Colors.white,
                          title: Text(dropDownList[index]),
                          onTap: () {
                            setState(() {
                              this.foos = dropDownList[index].toString();
                              _collapse();
                            });
                          },
                        ),
                      );
                    },
                  ),

                  // [
                  //   Container(
                  //     color: Colors.white,
                  //     child: new ListTile(
                  //       tileColor: Colors.white,
                  //       title: const Text('One'),
                  //       onTap: () {
                  //         setState(() {
                  //           this.foos = 'One';
                  //           _collapse();
                  //         });
                  //       },
                  //     ),
                  //   ),
                  //   Container(
                  //     color: Colors.white,
                  //     child: new ListTile(
                  //       title: const Text('Two'),
                  //       onTap: () {
                  //         setState(() {
                  //           this.foos = 'Two';
                  //           _collapse();
                  //         });
                  //       },
                  //     ),
                  //   ),
                  //   Container(
                  //     color: Colors.white,
                  //     child: new ListTile(
                  //       title: const Text('Three'),
                  //       onTap: () {
                  //         setState(() {
                  //           this.foos = 'Three';
                  //           _collapse();
                  //         });
                  //       },
                  //     ),
                  //   ),
                  //   SizedBox(height: 10,),
                  // ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              IconButton(
                onPressed: () async {
                  final date = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020, 10, 10),
                    lastDate: DateTime(2024, 11, 30),
                    // currentDate: DateTime(2022, 10, 15),
                    // selectedDate: DateTime(2022, 10, 16),
                    // slidersColor: Colors.lightBlue,
                    // highlightColor: Colors.redAccent,
                    // slidersSize: 20,
                    // splashColor: Colors.lightBlueAccent,
                    // splashRadius: 40,
                  );
                },
                icon: Icon(Icons.date_range),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0.0),
                child: RangeDatePicker(
                  // slidersColor: Colors.red,
                  // highlightColor: Colors.pink,
                  // slidersSize: 0,
                  // splashColor: Colors.blue,
                  singelSelectedCellDecoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  selectedCellsDecoration: BoxDecoration(
                    color: Colors.orange.shade100,
                  ),
                  splashRadius: 40,
                  centerLeadingDate: true,
                  minDate: DateTime(2020, 10, 10),
                  maxDate: DateTime(2024, 10, 30),
                  onRangeSelected: (selectedDateRange) {
                    if (selectedDateRange != null) {
                      setState(() {
                        _startDate = selectedDateRange.start;
                        _endDate = selectedDateRange.end;

                        formattedStartDate = _startDate != null
                            ? DateFormat('dd-MM-yyyy').format(_startDate!)
                            : 'No date selected';
                        formattedEndDate = _endDate != null
                            ? DateFormat('dd-MM-yyyy').format(_endDate!)
                            : 'No date selected';
                      });
                    }
                  },
                ),
              ),
              Text(
                _startDate != null && _endDate != null
                    ? '-Selected Date Range-\n${formattedStartDate} - ${formattedEndDate}'
                    : 'No date selected',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0.0),
                child: DatePicker(
                  currentDateDecoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  selectedCellDecoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  minDate: DateTime(2020, 10, 10),
                  maxDate: DateTime(2024, 10, 30),
                  onDateSelected: (selectedDate) {
                    if (selectedDate != null) {
                      setState(() {
                        _startDateSingle = selectedDate;

                        formattedStartDateSingle = _startDateSingle != null
                            ? DateFormat('dd-MM-yyyy').format(_startDateSingle!)
                            : 'No date selected';
                      });
                    }
                  },
                ),
              ),
              Text("-Selected Date-\n$formattedStartDateSingle",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
