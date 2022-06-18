import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  static const baseUrl =
      'flutter-shop-app-dff32-default-rtdb.europe-west1.firebasedatabase.app';

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> addProduct(Product product) {
    var url = Uri.https(baseUrl, '/products.json');
    return http
        .post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'isFavorite': product.isFavorite,
      }),
    )
        .then((response) {
      var resMap = json.decode(response.body);
      final newProduct = Product(
        id: resMap['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.https(baseUrl, '/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, value) {
        loadedProducts.add(Product(
          id: prodId,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
          isFavorite: value['isFavorite'],
        ));
      });
      _items = [...loadedProducts];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == product.id);
    if (prodIndex >= 0) {
      try {
        final url = Uri.https(baseUrl, '/products/${product.id}.json');
        await http.patch(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
            }));
        _items[prodIndex] = product;
        notifyListeners();
      } catch (error) {
        print(error);
        rethrow;
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final url = Uri.https(baseUrl, '/products/$id.json');
      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        throw Exception();
      }
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
