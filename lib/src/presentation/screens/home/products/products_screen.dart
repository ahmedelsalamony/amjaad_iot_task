import 'package:amjaadiot_task/src/presentation/shared_widgets/top_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../business_logic/home_provider.dart';
import '../../../shared_widgets/products_list.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late HomeProvider provider;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int limit = 4;

  void _onRefresh() async {
    // monitor network fetch
    provider.getProducts(limit);
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    if (mounted) {
      setState(() {
        if (provider.totalProductsCount > limit) {
          limit += 4;
          provider.getProducts(limit);
        } else {
          const snackBar = SnackBar(
            content: Text('No more data to Load!'),
            backgroundColor: Colors.amber,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<HomeProvider>(context, listen: false);
    provider.getTotalProductsCount();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext? context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("release to load more");
          } else {
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView(
        children: [
          const TopCategories(),
          const Divider(
            indent: 8,
            endIndent: 8,
            color: Colors.blueGrey,
          ),
          ProductsList(
            limit: limit,
          )
        ],
      ),
    );
  }
}
