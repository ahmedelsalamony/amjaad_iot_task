import 'package:amjaadiot_task/src/app/routes/routes.dart';
import 'package:amjaadiot_task/src/business_logic/home_provider.dart';
import 'package:amjaadiot_task/src/presentation/shared_widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatefulWidget {
  final int limit;
  const ProductsList({Key? key, required this.limit}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);
    return FutureBuilder(
        future: provider.getProducts(widget.limit),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: ((context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.productDetails,
                            arguments: provider.products[index]);
                      },
                      child:
                          ProductItem(productData: provider.products[index]));
                }));
          }
        });
  }
}
