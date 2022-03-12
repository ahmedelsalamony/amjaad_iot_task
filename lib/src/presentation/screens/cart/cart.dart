import 'package:amjaadiot_task/src/app/constants.dart';
import 'package:amjaadiot_task/src/business_logic/home_provider.dart';
import 'package:amjaadiot_task/src/data/models/product.dart';
import 'package:amjaadiot_task/src/presentation/shared_widgets/cart_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'.tr()),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: FutureBuilder(
          future: homeProvider.getCartItem(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (homeProvider.cartItems.isNotEmpty) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '${homeProvider.cartItems.length}' " " + 'items'.tr(),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: homeProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                          product: homeProvider.cartItems[index],
                          onDeleteItem: () {
                            setState(() {});
                          },
                        );
                      })
                ],
              );
            } else {
              return const Center(
                child: Text('no orders yet'),
              );
            }
          }),
    );
  }
}
