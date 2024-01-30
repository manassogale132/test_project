import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/Products.dart';

class CartPage extends StatelessWidget {
  final List<Product> selectedProducts;

  const CartPage({super.key, required this.selectedProducts});

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
      body: selectedProducts.length > 0
          ? ListView.builder(
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedProducts[index].title),
                  subtitle: Text(selectedProducts[index].description),
                  leading: CachedNetworkImage(
                    height: 40,
                    width: 40,
                    // imageUrl: snapshot.data![index].thumbnailUrl,
                    imageUrl: selectedProducts[index].images[0],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "Cart is Empty!!!",
                style: TextStyle(fontSize: 22),
              ),
            ),
    );
  }
}
