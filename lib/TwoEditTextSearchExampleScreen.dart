import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchableListView extends StatefulWidget {
  @override
  _SearchableListViewState createState() => _SearchableListViewState();
}

class _SearchableListViewState extends State<SearchableListView> {
  late List<String> _listItems;
  late List<String> _filteredItems;
  late TextEditingController _searchController;
  final FocusNode _focusNode = FocusNode();

  DateTime? _startDateSingle;
  String formattedStartDateSingle = "";

  @override
  void initState() {
    super.initState();
    _listItems = List.generate(100, (index) => 'Item $index');
    _filteredItems = _listItems;
    _searchController = TextEditingController();
  }

  void _filterList(String searchText) {
    setState(() {
      _filteredItems = _listItems
          .where(
              (item) => item.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  Future<void> _showCalendarDialog(BuildContext context) async {
    DateTime? selectedDate;
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          contentPadding: EdgeInsets.all(25),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(16.0), // Adjust the value as needed
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    enableFeedback: false, backgroundColor: Colors.white, // Background color
                                    surfaceTintColor: Colors.white,
                                  ),
                                  child: !formattedStartDateSingle.isEmpty
                                      ? Text(
                                    formattedStartDateSingle,
                                    style: TextStyle(color: Colors.grey),
                                  )
                                      : Text(
                                    '--',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 30,
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    surfaceTintColor: Colors.blue,
                                  ),
                                  child: Text(
                                    'To',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.maxFinite,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          textTheme: Theme.of(context).textTheme.copyWith(
                            headline6: TextStyle(
                                fontSize: 14), // Change the font size here
                          ),
                        ),
                        child: DatePicker(
                          centerLeadingDate: true,
                          currentDateDecoration: BoxDecoration(
                            color: Colors.blueGrey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          selectedCellDecoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.zero,
                          currentDate: DateTime.now(),
                          minDate: DateTime.now(),
                          maxDate: DateTime.now().add(Duration(days: 60)),
                          currentDateTextStyle: TextStyle(color: Colors.white),
                          selectedCellTextStyle: TextStyle(color: Colors.white),
                          onDateSelected: (selectedDate) {
                            if (selectedDate != null) {
                              setState(() {
                                _startDateSingle = selectedDate;
                                formattedStartDateSingle =
                                    DateFormat('dd-MMM-yyyy')
                                        .format(selectedDate);
                              });
                            }
                          },
                          daysOfTheWeekTextStyle:
                          TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 90,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // Close the dialog without selecting the date
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Background color
                          surfaceTintColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: BorderSide(color: Colors.black), // Border color
                          ),
                        ),
                        child: Text(
                          'Done',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    if (selectedDate != null) {
      // Do something with the selected date
      print('Selected date: $selectedDate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search screen')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
        child: Column(
          children: [
            TextField(
              focusNode: _focusNode,
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterList('');
                    _focusNode.unfocus();
                  },
                ),
              ),
              onChanged: _filterList,
            ),
            if (_focusNode.hasFocus)
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredItems[index]),
                    );
                  },
                ),
              ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showCalendarDialog(context);
                },
                child: Text('Show Calendar Dialog'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
