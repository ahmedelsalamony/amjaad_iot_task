import 'package:amjaadiot_task/src/business_logic/home_provider.dart';
import 'package:amjaadiot_task/src/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final Product product;
  final Function() onDeleteItem;
  const CartItem({Key? key, required this.product, required this.onDeleteItem})
      : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.network(widget.product.image!),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(widget.product.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodySmall),
                  Text(widget.product.price!.toString() + ' \$'),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      itemCount += 1;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
                Text('$itemCount'),
                IconButton(
                  onPressed: () {
                    if (itemCount == 1) {
                      widget.onDeleteItem();
                      Provider.of<HomeProvider>(context, listen: false)
                          .deleteCartItem(widget.product);
                    }
                    setState(() {
                      if (itemCount > 1) {
                        itemCount -= 1;
                      }
                    });
                  },
                  icon: Icon(Icons.minimize_outlined),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
