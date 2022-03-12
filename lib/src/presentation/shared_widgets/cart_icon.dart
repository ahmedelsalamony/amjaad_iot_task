import 'package:amjaadiot_task/src/app/routes/routes.dart';
import 'package:amjaadiot_task/src/business_logic/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatefulWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  HomeProvider? homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.shopping_cart_outlined,
          size: 26,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.cart);
        },
      ),
      Stack(
        children: [
          FutureBuilder(
            future: context.watch<HomeProvider>().getCartItem(),
            builder: (context, snapshot) {
              return context.watch<HomeProvider>().cartItems.isNotEmpty
                  ? Positioned(
                      child: Stack(
                      children: <Widget>[
                        const Icon(Icons.brightness_1,
                            size: 24.0, color: Colors.red),
                        Positioned(
                            top: 4.0,
                            left: 8.0,
                            child: Center(
                              child: Text(
                                context
                                    .watch<HomeProvider>()
                                    .cartItems
                                    .length
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    ))
                  : Container();
            },
          ),
        ],
      ),
    ]);
  }
}
