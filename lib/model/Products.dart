import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  List<Product> products;
  int total;
  int skip;
  int limit;

  Products({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    products: List<Product>.from(
        json["products"].map((x) => Product.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };

  @override
  String toString() {
    return 'Products(products: $products, total: $total, skip: $skip, limit: $limit)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Products &&
              runtimeType == other.runtimeType &&
              products == other.products &&
              total == other.total &&
              skip == other.skip &&
              limit == other.limit;

  @override
  int get hashCode =>
      products.hashCode ^ total.hashCode ^ skip.hashCode ^ limit.hashCode;
}

class Product {
  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;
  Color color; // New color parameter

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.color, // Added color parameter
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final random = Random();
    final r = random.nextInt(256);
    final g = random.nextInt(256);
    final b = random.nextInt(256);
    final color = Color.fromARGB(255, r, g, b); // Generate random color
    return Product(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      discountPercentage: json["discountPercentage"]?.toDouble() ?? 0.0,
      rating: json["rating"]?.toDouble() ?? 0.0,
      stock: json["stock"],
      brand: json["brand"],
      category: json["category"],
      thumbnail: json["thumbnail"],
      images: List<String>.from(json["images"].map((x) => x)),
      color: color, // Assign random color
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "category": category,
    "thumbnail": thumbnail,
    "images": List<dynamic>.from(images.map((x) => x)),
  };

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, brand: $brand, category: $category, thumbnail: $thumbnail, images: $images, color: $color)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              description == other.description &&
              price == other.price &&
              discountPercentage == other.discountPercentage &&
              rating == other.rating &&
              stock == other.stock &&
              brand == other.brand &&
              category == other.category &&
              thumbnail == other.thumbnail &&
              images == other.images &&
              color == other.color;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      discountPercentage.hashCode ^
      rating.hashCode ^
      stock.hashCode ^
      brand.hashCode ^
      category.hashCode ^
      thumbnail.hashCode ^
      images.hashCode ^
      color.hashCode;
}
