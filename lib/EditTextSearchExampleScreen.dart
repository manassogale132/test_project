import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/Products.dart';
import 'package:http/http.dart' as http;

class EditTextSearchExampleScreen extends StatefulWidget {
  @override
  _EditTextSearchExampleScreenState createState() =>
      _EditTextSearchExampleScreenState();
}

class _EditTextSearchExampleScreenState
    extends State<EditTextSearchExampleScreen> {
  late Products products;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  TextEditingController _textEditingController = TextEditingController();
  bool _isLoading = true;
  String _selectedTitle = ''; // Track selected title

  Future<Products> getProducts() async {
    var url = 'https://dummyjson.com/products';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        setState(() {
          products = productsFromJson(response.body);
          _products = products.products;
          _filteredProducts = _products;
          _isLoading = false;
        });
      } else {
        print('Something went wrong!');
        _isLoading = false;
      }
    } catch (exception) {}
    return products;
  }

  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    getProducts();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  void _searchProducts(String searchText) {
    setState(() {
      _textEditingController.text = searchText; // Update text field value
      _filteredProducts = _products
          .where((product) =>
              product.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void getSelectedTitle(int index) {
    _selectedTitle = _filteredProducts[index].title;
    _textEditingController.text = _selectedTitle;
  }

  void _clearFocus() {
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(color: Colors.white),
          centerTitle: true,
          title: Text(
            "EditTextSearchExampleScreen",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: _isLoading
            ? Center(
                child:
                    CircularProgressIndicator()) // Show CircularProgressIndicator if loading
            : GestureDetector(
                onTap: () {
                  if (_filteredProducts.isEmpty) {
                    _textEditingController.clear();
                    _searchProducts('');
                  }

                  _clearFocus();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Visibility(
                              visible: _focusNode.hasFocus,
                              child: Transform.translate(
                                offset: Offset(0, 55),
                                //offset: Offset(0, 40),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  height: 260,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                      topLeft: Radius.circular(8.0),
                                    ),
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade500),
                                      left: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade500),
                                      right: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade500),
                                      top: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade500),
                                    ),
                                  ),
                                  child: _filteredProducts.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: _filteredProducts.length,
                                          itemBuilder: (context, index) {
                                            // Generate random RGB values
                                            // final Random random = Random();
                                            // final int red =
                                            //     random.nextInt(256);
                                            // final int green =
                                            //     random.nextInt(256);
                                            // final int blue =
                                            //     random.nextInt(256);
                                            // // Create color from RGB values
                                            // final Color color =
                                            //     Color.fromRGBO(
                                            //         red, green, blue, 1.0);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  getSelectedTitle(index);
                                                  _clearFocus();
                                                },
                                                child: ListTile(
                                                  title: Text(
                                                    _filteredProducts[index]
                                                        .title,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  subtitle: Text(
                                                    _filteredProducts[index]
                                                        .description,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  leading: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: Center(
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                        _filteredProducts[
                                                        index]
                                                            .color,
                                                        child: Text(
                                                          _filteredProducts[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                      : Center(
                                          child: Text(
                                            "No data avialable.",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            CupertinoTextField(
                              onChanged: (text) {
                                _searchProducts(text);
                              },
                              controller: _textEditingController,
                              style: TextStyle(fontSize: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: _focusNode.hasFocus
                                      ? Colors.green
                                      : Colors.grey.shade400,
                                  width: _focusNode.hasFocus ? 1.5 : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusNode: _focusNode,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 16),
                              placeholder: 'Search product here.....',
                              placeholderStyle:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                              suffix: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: _focusNode.hasFocus
                                    ? GestureDetector(
                                        onTap: () {
                                          if (_filteredProducts.isEmpty) {
                                            _textEditingController.clear();
                                            _searchProducts('');
                                          }

                                          _clearFocus();
                                          // _searchProducts('');
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.grey.shade600,
                                          size: 20,
                                        ),
                                      )
                                    : Icon(
                                        Icons.search,
                                        color: Colors.grey.shade600,
                                        size: 20,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: List.generate(_products.length, (index) {
                            return ListTile(
                              title: Text(_products[index].title),
                              subtitle: Text(_products[index].description),
                            );
                          }),
                        ),
                        // ListView.builder(
                        //     shrinkWrap: true,
                        //     itemCount: _products.length,
                        //     itemBuilder: (context, index) {
                        //       return ListTile(
                        //         title: Text(_products[index].title),
                        //         subtitle: Text(_products[index].description),
                        //       );
                        //     }),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
