import 'package:flutter/material.dart';

import '../../data/models/product.dart';

class ProductItem extends StatefulWidget {
  final Product productData;
  const ProductItem({Key? key, required this.productData}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                child: SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.network(
                      '${widget.productData.image}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: isFavorite
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: const Icon(Icons.favorite_border)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.productData.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('${widget.productData.price!}',
                style: Theme.of(context).textTheme.headline2),
          ),
        ],
      ),
    );
  }
}
