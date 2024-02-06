import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_project/CartPage.dart';

import 'AddedCartProductsScreen.dart';
import 'model/Posts.dart';
import 'model/Products.dart';

class RealEstate extends StatefulWidget {
  const RealEstate({super.key});

  @override
  State<RealEstate> createState() => _RealEstateState();
}

class _RealEstateState extends State<RealEstate> {
  int? len = 0;

  Future<List<Post>> getPosts() async {
    var url = 'https://jsonplaceholder.typicode.com/photos';
    List<Post> result = [];

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        result = postFromJson(response.body);
      } else {
        print('Something went wrong!');
      }
    } catch (exception) {}
    return result;
  }

  late Products products;
  List<Product> selectedProducts = [];

  Future<Products> getProducts() async {
    var url = 'https://dummyjson.com/products';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        products = productsFromJson(response.body);
      } else {
        print('Something went wrong!');
      }
    } catch (exception) {}
    return products;
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  } // void addProductsToCart(int index) {
  //   selectedProducts.add(index as Products);
  //   var snackBar = SnackBar(
  //     content: Text('Selected Products length - ${selectedProducts.length}'),
  //     backgroundColor: Colors.green,
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  // List<Products> listOfProducts = [];

  // Future<List<Post>> getPosts() async {
  //   var url = 'https://jsonplaceholder.typicode.com/photos';
  //   List<Post> result = [];
  //
  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     if (response.statusCode == HttpStatus.ok) {
  //       result = postFromJson(response.body);
  //
  //       SharedPreferences preferences = await SharedPreferences.getInstance();
  //       Map<String, dynamic> json = jsonDecode(response.body);
  //       if (json != null) {
  //         String post = jsonEncode(Post.fromJson(json));
  //         preferences.setString('postData', post);
  //       }
  //     } else {
  //       print('Something went wrong!');
  //     }
  //   } catch (exception) {}
  //   return result;
  // }
  //
  // Future<Post> getSavedInfo()async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   Map<String, dynamic> postMap = jsonDecode(preferences.getString("postData").toString());
  //   Post post = Post.fromJson(postMap);
  //   return post;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Product Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage(
                            selectedProducts: selectedProducts,
                          )));
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.purple],
              // Define your gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          //future: getPosts(),
          future: getProducts(),
          builder: (context, snapshot) {
            len = snapshot.data?.products.length;
            print('Total Products List Size - ${len}');
            return snapshot.hasData
                ? CupertinoScrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                        //itemCount: snapshot.data?.length,
                        itemCount: snapshot.data?.products.length,
                        itemBuilder: (context, index) {
                          // nestedList = snapshot.data!.products[index].images;
                          // if (nestedList.length > 1) {
                          //   nestedList.removeAt(1);
                          // }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (!selectedProducts.contains(
                                      snapshot.data!.products[index])) {
                                    selectedProducts
                                        .add(snapshot.data!.products[index]);
                                    print(
                                        'Total selectedProducts List Size - ${selectedProducts.length}');
                                  }
                                });
                              },
                              child: Card(
                                elevation: 0,
                                color: selectedProducts.contains(
                                        snapshot.data!.products[index])
                                    ? Colors.orangeAccent
                                    : Color(0xffefedf0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0,
                                    vertical: 12.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        height: 190,
                                        width: 100,
                                        // imageUrl: snapshot.data![index].thumbnailUrl,
                                        imageUrl: snapshot
                                            .data!.products[index].images[0],
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Center(
                                          child: Container(
                                            height: 160,
                                            width: 100,
                                            color: Colors.black12,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.black12,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Icon(Icons.error),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 18,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              //snapshot.data![index].title,
                                              snapshot
                                                  .data!.products[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              snapshot.data!.products[index]
                                                  .description,
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Container(
                                              height: 60,
                                              child: CupertinoScrollbar(
                                                thumbVisibility: false,
                                                child: ListView.builder(
                                                    itemCount: snapshot
                                                        .data!
                                                        .products[index]
                                                        .images
                                                        .length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, imageIndex) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 8.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          height: 60,
                                                          width: 50,
                                                          // imageUrl: snapshot.data![index].thumbnailUrl,
                                                          imageUrl:
                                                              snapshot
                                                                      .data!
                                                                      .products[
                                                                          index]
                                                                      .images[
                                                                  imageIndex],
                                                          // imageUrl: nestedList[index],
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .black12,
                                                              // borderRadius: BorderRadius.circular(8.0),
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                            child: Container(
                                                              height: 160,
                                                              width: 100,
                                                              color: Colors
                                                                  .black12,
                                                              child: Center(
                                                                child: SizedBox(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .black12,
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Center(
                                                            child: Icon(
                                                                Icons.error),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Column(
                                                  children: [
                                                    Icon(Icons.heart_broken,
                                                        color: Colors.red,
                                                        size: 20),
                                                    Text(
                                                      // snapshot.data![index].id
                                                      //     .toString(),
                                                      snapshot.data!
                                                          .products[index].price
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(Icons.share,
                                                        color: Colors.grey,
                                                        size: 20),
                                                    Text(
                                                      // snapshot.data![index].albumId
                                                      //     .toString(),
                                                      snapshot.data!
                                                          .products[index].stock
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Set the elevation for a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // Adjust the value for rounded corners
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10), // Adjust padding as needed
        leading: Container(
          height: double.infinity,
          width: 80, // Set the width for the image container
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8), // Adjust as needed
            child: Image.network(
              'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L25zMTQ2NTEtaW1hZ2Uta3d2eWQybmIuanBn.jpg',
              // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text('Title'),
        subtitle: Text(
          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available',
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
