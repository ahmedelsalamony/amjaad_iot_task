import 'package:amjaadiot_task/src/app/constants.dart';
import 'package:amjaadiot_task/src/data/models/product.dart';
import 'package:amjaadiot_task/src/presentation/shared_widgets/cart_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../app/routes/routes.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.cart);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CartIcon(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.network(
                  product.image!,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Text(
              product.title!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Text(product.description!,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              children: [
                Text(
                  'price'.tr(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  ':',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text('${product.price!}',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.red.shade700)),
              ],
            ),
          ),
          RatingBar.builder(
            ignoreGestures: true,
            initialRating: double.parse(product.rating!.rate!.toString()),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          const SizedBox(
            height: 160,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () async {
                //open box
                var box =
                    await Hive.openBox<Product>(Constants.cartItemboxName);
                //add item to cart list items
                box.add(product).then((value) => print(value));
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: Center(
                  child: Text('addToCart'.tr()),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
