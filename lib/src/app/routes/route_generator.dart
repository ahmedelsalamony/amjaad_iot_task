import 'package:amjaadiot_task/src/app/constants.dart';
import 'package:amjaadiot_task/src/app/routes/routes.dart';
import 'package:amjaadiot_task/src/presentation/addresses/addresses.dart';
import 'package:amjaadiot_task/src/presentation/screens/cart/cart.dart';
import 'package:amjaadiot_task/src/presentation/screens/home/home_container.dart';
import 'package:amjaadiot_task/src/presentation/screens/home/products/products_screen.dart';
import 'package:amjaadiot_task/src/presentation/screens/map/map_screen.dart';
import 'package:amjaadiot_task/src/presentation/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';

import '../../data/models/product.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomeContainer());
      case Routes.products:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const ProductsScreen());
      case Routes.addresses:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Addresses());
      case Routes.map:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const MapScreen());
      case Routes.cart:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Cart());
      case Routes.productDetails:
        Product product = settings.arguments as Product;
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProductDetails(
                  product: product,
                ));

      default:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const ProductsScreen());
    }
  }
}
