import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

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

  PageController _controller = PageController();
  int _currentPage = 0;

  int stepCounter = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
    _collapse();
  }

  List<String> dropDownList = ["One", "Two", "Three"];

  DateTime _startDateDynamicRange = DateTime.now();
  DateTime _endDateDynamicRange = DateTime.now().add(Duration(days: 7));

  //date values for range
  DateTime? _startDate;
  DateTime? _endDate;
  String formattedStartDate = "";
  String formattedEndDate = "";

  //single date selected
  DateTime? _startDateSingle;
  String formattedStartDateSingle = "";

  List<int> bannerCount = [1, 2, 3];

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
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dropdown",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                    style: TextStyle(fontWeight: FontWeight.bold),
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Progress",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (stepCounter != 0) {
                            stepCounter--;
                          }
                        });
                      },
                      child: Icon(
                        Icons.exposure_minus_1,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressBar(
                          maxSteps: 9,
                          progressType: LinearProgressBar.progressTypeLinear,
                          currentStep: stepCounter,
                          progressColor: Colors.green,
                          backgroundColor: Colors.grey,
                          // dotsAxis: Axis.horizontal,
                          // // OR Axis.vertical
                          // dotsActiveSize: 10,
                          // dotsInactiveSize: 10,
                          // dotsSpacing: EdgeInsets.only(right: 10),
                          // also can use any EdgeInsets.
                          semanticsLabel: "Label",
                          semanticsValue: "Value",
                          minHeight: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (stepCounter != 9) {
                            stepCounter++;
                          }
                        });
                      },
                      child: Icon(
                        Icons.plus_one,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$stepCounter',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Banners",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 110,
                child: PageView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: bannerCount.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.grey[200],
                          child: Image.network(
                            'https://via.placeholder.com/600',
                            fit: BoxFit.cover, // Adjust this to fit your needs
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  bannerCount.length,
                  (index) => Padding(
                    padding: _currentPage == index
                        ? EdgeInsets.all(8.0)
                        : EdgeInsets.all(4.0),
                    child: Container(
                      width: _currentPage == index ? 20 : 10,
                      height: 5,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.blue
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the value as needed
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   width: 8,
              //   height: 12,
              //   color: Colors.grey[200],
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Calender's",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final date = await showDateRangePicker(
                    context: context,
                    // firstDate: DateTime(2020, 10, 10),
                    // lastDate: DateTime(2027, 10, 10),
                    firstDate: DateTime.now().subtract(Duration(days: 60)),
                    lastDate: DateTime.now().add(Duration(days: 60)),
                    // currentDate: DateTime(2022, 10, 15),
                    // selectedDate: DateTime(2022, 10, 16),
                    // slidersColor: Colors.lightBlue,
                    // highlightColor: Colors.redAccent,
                    // slidersSize: 20,
                    // splashColor: Colors.lightBlueAccent,
                    // splashRadius: 40,
                  );
                  // final pickedRange = await showDateRangePicker(
                  //   context: context,
                  //   initialDateRange: DateTimeRange(
                  //       start: _startDateDynamicRange,
                  //       end: _endDateDynamicRange),
                  //   firstDate: DateTime.now().subtract(Duration(days: 365)),
                  //   lastDate: DateTime.now().add(Duration(days: 365)),
                  // );
                  //
                  // if (pickedRange != null) {
                  //   setState(() {
                  //     _startDateDynamicRange = pickedRange.start;
                  //     _endDateDynamicRange = pickedRange.end;
                  //   });
                  // }
                },
                icon: Icon(
                  Icons.date_range,
                  size: 50,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(
                height: 10,
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
