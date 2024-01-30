import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/model/Products.dart';

class AddedCartProductsScreen extends StatelessWidget {
  final List<Product> products;

  const AddedCartProductsScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Cart Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xffefedf0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  CachedNetworkImage(
                    height: 180,
                    width: 100,
                    // imageUrl: snapshot.data![index].thumbnailUrl,
                    imageUrl: products[index].images[0],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8.0),
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
                    errorWidget: (context, url, error) => Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //snapshot.data![index].title,
                          products[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          products[index].description,
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
                                itemCount: products[index].images.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, imageIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CachedNetworkImage(
                                      height: 60,
                                      width: 50,
                                      // imageUrl: snapshot.data![index].thumbnailUrl,
                                      imageUrl:
                                          products[index].images[imageIndex],
                                      // imageUrl: nestedList[index],
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          // borderRadius: BorderRadius.circular(8.0),
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
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.black12,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: Icon(Icons.error),
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.heart_broken,
                                    color: Colors.red, size: 20),
                                Text(
                                  // snapshot.data![index].id
                                  //     .toString(),
                                  products[index].price.toString(),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              children: [
                                Icon(Icons.share, color: Colors.grey, size: 20),
                                Text(
                                  // snapshot.data![index].albumId
                                  //     .toString(),
                                  products[index].stock.toString(),
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
          );
        },
      ),
    );
  }
}
