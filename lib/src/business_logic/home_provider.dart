import 'package:amjaadiot_task/src/data/models/address.dart';
import 'package:amjaadiot_task/src/data/models/product.dart';
import 'package:amjaadiot_task/src/data/repository/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../app/constants.dart';

class HomeProvider extends ChangeNotifier {
  int _bottomNavigationCurrentIndex = 0;
  List<dynamic> categories = [];
  List<Product> products = [];
  HomeRepo? homeRepo;
  bool hasMore = true;
  int totalProductsCount = 0;
  List<Product> cartItems = [];
  int selectedCategory = 0;
  List<Address> addresses = [];

  HomeProvider(this.homeRepo);

  int get bottomNavigationCurrentIndex => _bottomNavigationCurrentIndex;

  setSelectedCategory(int index) {
    selectedCategory = index;
    notifyListeners();
  }

  set bottmNavigationCurrentIndex(int value) {
    _bottomNavigationCurrentIndex = value;
    notifyListeners();
  }

  Future<void> getAllCategories() async {
    categories = await homeRepo!.getCtaegories();
    notifyListeners();
  }

  Future<void> getProducts(int limit, {String category = ''}) async {
    try {
      if (selectedCategory == 0) {
        products = await homeRepo!.getProducts(limit);
      } else {
        products = await homeRepo!.productsByCategory(category);
      }

      notifyListeners();
    } catch (e) {
      hasMore = false;
      notifyListeners();
    }
  }

  Future<void> getTotalProductsCount() async {
    totalProductsCount = await homeRepo!.totalProductsCount();
    notifyListeners();
  }

  Future<void> getCartItem() async {
    cartItems = await homeRepo!.getCartItems();
    notifyListeners();
  }

  Future<void> deleteCartItem(Product item) async {
    await homeRepo!.removeCartItem(item);
    cartItems.remove(item);
    notifyListeners();
  }

  Future<void> insertNewAddress(Address address) async {
    await homeRepo!.insertNewAddress(address);
    notifyListeners();
  }

  Future<void> getAddresses() async {
    addresses = await homeRepo!.getAddresses();
    notifyListeners();
  }

  void setLang(bool lang) async {
    var box = Hive.box(Constants.appConfigBoxName);
    box.put(Constants.appLang, lang);
  }

  bool getLang() {
    var box = Hive.box(Constants.appConfigBoxName);
    bool value = box.get(Constants.appLang, defaultValue: false);
    return value;
  }

  void setAllowNotificationValue(bool value) {
    var box = Hive.box(Constants.appConfigBoxName);
    box.put(Constants.allowNotification, value);
  }

  bool getAllowNotificationValue() {
    var box = Hive.box(Constants.appConfigBoxName);
    bool value = box.get(Constants.allowNotification, defaultValue: false);
    return value;
  }

  void setAllowLocationValue(bool value) {
    var box = Hive.box(Constants.appConfigBoxName);
    box.put(Constants.allowLocation, value);
  }

  bool getAllowLocationValue() {
    var box = Hive.box(Constants.appConfigBoxName);
    bool val = box.get(Constants.allowLocation, defaultValue: false);
    return val;
  }
}
