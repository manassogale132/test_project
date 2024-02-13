import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import 'model/Posts.dart';

class PaginationAtLocalScreen extends StatefulWidget {
  @override
  _PaginationAtLocalScreenState createState() =>
      _PaginationAtLocalScreenState();
}

class _PaginationAtLocalScreenState extends State<PaginationAtLocalScreen> {
  List<Post> postData = [];
  int _visibleItemCount = 6;
  int _startIndex = 0;
  bool _loading = false;

  List<Post> postDataTwo = [];
  int _visibleItemCountTwo = 3;
  int _startIndexTwo = 0;
  bool _loadingTwo = false;

  List<dynamic> responseData = [];
  int pageCount = 0;

  Future<List<Post>> fetchPostAPI() async {
    // Fetch data from your API
    var url = 'https://jsonplaceholder.typicode.com/photos';
    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        if (postData.isEmpty) {
          postData = responseData
              .take(_visibleItemCount)
              .map((item) => Post.fromJson(item))
              .toList();
          _startIndex = _visibleItemCount;
        } else {
          // Replace the existing items with the next two items from the API
          postData = responseData
              .skip(_startIndex) // Skip already loaded items
              .take(_visibleItemCount) // Take only the next two items
              .map((item) => Post.fromJson(item))
              .toList();
          _startIndex += _visibleItemCount;
        }
      });
    }
    return postData;
  }

  Future<List<Post>> fetchPostAPITwo() async {
    // Fetch data from your API
    var url = 'https://jsonplaceholder.typicode.com/photos';
    // Simulate API call delay
    // await Future.delayed(Duration(seconds: 2));
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      responseData = json.decode(response.body);

      final itemCount = responseData.length;
      final itemsPerPage = 3;

      pageCount = (itemCount / itemsPerPage).ceil();
      print('Number of pages: $pageCount');

      setState(() {
        if (postDataTwo.isEmpty) {
          postDataTwo = responseData
              .take(_visibleItemCountTwo)
              .map((item) => Post.fromJson(item))
              .toList();
          _startIndexTwo = _visibleItemCountTwo;
        } else {
          // Replace the existing items with the next two items from the API
          postDataTwo = responseData
              .skip(_startIndexTwo) // Skip already loaded items
              .take(_visibleItemCountTwo) // Take only the next two items
              .map((item) => Post.fromJson(item))
              .toList();
          _startIndexTwo += _visibleItemCountTwo;
        }
      });
    }
    return postDataTwo;
  }

  @override
  void initState() {
    super.initState();
    fetchPostAPI();
    fetchPostAPITwo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Data List',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.plus_one,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _loading = true;
              });
              fetchPostAPI().then((_) {
                setState(() {
                  _loading = false;
                });
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exposure_plus_2,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _loadingTwo = true;
              });
              fetchPostAPITwo().then((_) {
                setState(() {
                  _loadingTwo = false;
                });
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            postData.isNotEmpty && !_loading
                ? Container(
                    height: 250,
                    child: ListView.builder(
                      itemCount: postData.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(postData[index].title),
                          leading: CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Text(
                              postData[index].id.toString(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          subtitle: Text(
                            postData[index].url,
                          ),
                          trailing: Text(
                            "${index}",
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      },
                    ),
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 250,
                      child: ListView.builder(
                        itemCount: _visibleItemCount,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Loading'),
                            subtitle: Text('Loading'),
                            leading: CircleAvatar(),
                          );
                        },
                      ),
                    ),
                  ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //   child: DottedLine(),
            // ),
            // postDataTwo.isNotEmpty && !_loadingTwo
            //     ? Container(
            //         height: 250,
            //         child: ListView.builder(
            //           itemCount: postDataTwo.length,
            //           itemBuilder: (context, index) {
            //             return ListTile(
            //               title: Text(postDataTwo[index].title),
            //               leading: CircleAvatar(
            //                 backgroundColor: Colors.greenAccent,
            //                 child: Text(
            //                   postDataTwo[index].id.toString(),
            //                   style:
            //                       TextStyle(fontSize: 18, color: Colors.black),
            //                 ),
            //               ),
            //               subtitle: Text(
            //                 postDataTwo[index].url,
            //               ),
            //               trailing: Text(
            //                 "${index}",
            //                 style: TextStyle(fontSize: 18),
            //               ),
            //             );
            //           },
            //         ),
            //       )
            //     : Shimmer.fromColors(
            //         baseColor: Colors.grey[400]!,
            //         highlightColor: Colors.grey[100]!,
            //         child: Container(
            //           height: 250,
            //           child: ListView.builder(
            //             itemCount: _visibleItemCountTwo,
            //             itemBuilder: (context, index) {
            //               return ListTile(
            //                 title: Text('Loading'),
            //                 subtitle: Text('Loading'),
            //                 leading: CircleAvatar(),
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DottedLine(),
            ),
            Container(
              color: Colors.grey.shade200,
              child: Column(
                children: postDataTwo.isNotEmpty && !_loadingTwo
                    ? List.generate(
                        postDataTwo.length,
                        (index) => ListTile(
                          title: Text(postDataTwo[index].title),
                          leading: CircleAvatar(
                            backgroundColor: Colors.greenAccent,
                            child: Text(
                              postDataTwo[index].id.toString(),
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          subtitle: Text(
                            postDataTwo[index].url,
                          ),
                          trailing: Text(
                            "${index}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    : List.generate(
                        postDataTwo.length,
                        (index) => Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListTile(
                            title: Text(postDataTwo[index].title),
                            leading: CircleAvatar(
                              backgroundColor: Colors.greenAccent,
                              child: Text(
                                postDataTwo[index].id.toString(),
                                style:
                                    TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                            subtitle: Text(
                              postDataTwo[index].url,
                            ),
                            trailing: Text(
                              "${index}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20,),
            Text('${pageCount} out of ${responseData.length.toString()}',style: TextStyle(fontSize: 16),),
            // postData.isNotEmpty && !_loading
            //     ? Container(
            //   height: 250,
            //   child: ListView.builder(
            //     itemCount: postData.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(postData[index].title),
            //         leading: CircleAvatar(
            //           backgroundColor: Colors.yellow,
            //           child: Text(
            //             postData[index].id.toString(),
            //             style:
            //             TextStyle(fontSize: 18, color: Colors.white),
            //           ),
            //         ),
            //         subtitle: Text(
            //           postData[index].url,
            //         ),
            //         trailing: Text(
            //           "${index}",
            //           style: TextStyle(fontSize: 18),
            //         ),
            //       );
            //     },
            //   ),
            // )
            //     : Shimmer.fromColors(
            //   baseColor: Colors.grey[400]!,
            //   highlightColor: Colors.grey[100]!,
            //   child: Container(
            //     height: 250,
            //     child: ListView.builder(
            //       itemCount: _visibleItemCount,
            //       itemBuilder: (context, index) {
            //         return ListTile(
            //           title: Text('Loading'),
            //           subtitle: Text('Loading'),
            //           leading: CircleAvatar(),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DottedLine(),
            ),
          ],
        ),
      ),
    );
  }
}
