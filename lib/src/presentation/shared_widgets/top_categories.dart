import 'package:amjaadiot_task/src/business_logic/home_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_item.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.getAllCategories(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    CategoryItem(
                      itemName: 'allProducts'.tr(),
                      onPress: () {
                        print('i');
                      },
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: ((context, index) {
                          return CategoryItem(
                            itemName: provider.categories[index].toString(),
                            onPress: () {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .setSelectedCategory(index);
                              Provider.of<HomeProvider>(context, listen: false)
                                  .getProducts(4,
                                      category: provider.categories[index]
                                          .toString());
                              // await context.watch<HomeProvider>().getProducts(4,
                              //     category:
                              //         provider.categories[index].toString());
                            },
                          );
                        }))
                  ],
                ),
              );
      },
    );
  }
}
