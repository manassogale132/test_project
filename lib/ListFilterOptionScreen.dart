import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class ListFilterOptionScreenExampel extends StatefulWidget {
  @override
  _ListFilterOptionScreenExampelState createState() =>
      _ListFilterOptionScreenExampelState();
}

class _ListFilterOptionScreenExampelState
    extends State<ListFilterOptionScreenExampel> {
  late Future<List<Post>> _data;
  String _selectedFilter = '';
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _data = fetchData();
  }

  Future<List<Post>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return List<Post>.from(list.map((model) => Post.fromJson(model)));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _onFilterSelected(String filter) async {
    setState(() {
      if (_selectedFilter == filter) {
        _selectedFilter = ''; // Deselect if the same filter is clicked again
      } else {
        _selectedFilter = filter;
      }
    });
  }

  List<Post> _filterData(List<Post> data) {
    if (_selectedFilter.isEmpty) {
      return data;
    } else {
      return data.where((item) => item.id == int.parse(_selectedFilter)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API ListView Example'),
        actions: [
          FutureBuilder<List<Post>>(
            future: _data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                Set<String> uniqueIds = Set();
                for (var item in snapshot.data!) {
                  uniqueIds.add(item.id.toString());
                }
                return PopupMenuButton<String>(
                  icon: Icon(Icons.filter_alt),
                  color: Colors.white,
                  constraints: BoxConstraints.tightFor(
                    height: 300,
                    width: MediaQuery.of(context).size.width * 0.50,
                  ),
                  itemBuilder: (BuildContext context) {
                    List<PopupMenuEntry<String>> menuItems = [
                      PopupMenuItem<String>(
                        value: '',
                        child: ListTile(
                          title: Text(
                            'Show All',
                            style: TextStyle(
                              color: _selectedFilter.isEmpty
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ];
                    for (var id in uniqueIds) {
                      menuItems.add(
                        PopupMenuItem<String>(
                          value: id,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('ID $id'),
                                Icon(
                                  _selectedFilter == id
                                      ? Icons.check_circle_outline
                                      : Icons.circle_outlined,
                                  color: _selectedFilter == id
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return menuItems;
                  },
                  onSelected: _onFilterSelected,
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ClipRRect(
            clipBehavior: Clip.values[3],
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: SizedBox(
              width: Checkbox.width,
              height: Checkbox.width,
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: new BorderRadius.circular(50),
                ),
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.white,
                  ),
                  child: Checkbox(
                    value: _value,
                    onChanged: (state) =>
                        setState(() => _value = !_value),
                    activeColor: Colors.transparent,
                    checkColor: Colors.blue,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Post>>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final filteredData = _filterData(snapshot.data!);
                  return ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(filteredData[index].id.toString()),
                        title: Text(filteredData[index].title),
                        subtitle: Text(filteredData[index].body),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
