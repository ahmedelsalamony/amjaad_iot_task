import 'dart:convert';

import 'package:amjaadiot_task/src/app/constants.dart';
import 'package:amjaadiot_task/src/app/end_points.dart';
import 'package:amjaadiot_task/src/data/models/address.dart';
import 'package:amjaadiot_task/src/data/models/product.dart';
import 'package:amjaadiot_task/src/data/web_services/home.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeRepo {
  late HomeWebService homeWebService;

  HomeRepo() {
    homeWebService = HomeWebService();
  }

  Future<List<dynamic>> getCtaegories() async {
    dynamic response =
        await homeWebService.getCategories(EndPoints.allCategories);
    return response;
  }

  Future<List<Product>> getProducts(int limit) async {
    List<Product> products = [];
    final result =
        await homeWebService.getProducts(EndPoints.allProducts + '$limit');

    for (int i = 0; i < result.length; i++) {
      products.add(Product.fromJson(result[i]));
    }
    return products;
  }

  Future<int> totalProductsCount() async {
    int productsCount = await homeWebService.getProductsCount();
    return productsCount;
  }

  Future<List<Product>> getCartItems() async {
    var box = await Hive.openBox<Product>(Constants.cartItemboxName);
    return box.values.toList();
  }

  Future<void> removeCartItem(Product item) async {
    var box = await Hive.openBox<Product>(Constants.cartItemboxName);
    await box.deleteAt(box.values.toList().indexOf(item));
  }

  Future<int> insertNewAddress(Address address) async {
    var box = await Hive.openBox<Address>(Constants.addressesBoxName);
    return box.add(address);
  }

  Future<List<Address>> getAddresses() async {
    var box = await Hive.openBox<Address>(Constants.addressesBoxName);
    return box.values.toList();
  }

  Future<List<Product>> productsByCategory(String category) async {
    List<Product> products = [];
    final result = await homeWebService.getProductsByCategory(category);
    for (int i = 0; i < result.length; i++) {
      products.add(Product.fromJson(result[i]));
    }
    return result;
  }
}
