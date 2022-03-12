import 'package:amjaadiot_task/src/business_logic/home_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../app/routes/routes.dart';
import '../shared_widgets/cart_icon.dart';

class Addresses extends StatefulWidget {
  const Addresses({Key? key}) : super(key: key);

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  late HomeProvider homeProvider;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of(context, listen: false);

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed(Routes.map);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: Center(
                  child: Text('addAddress'.tr()),
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: context.watch<HomeProvider>().getAddresses(),
              builder: (context, snashot) {
                if (context.watch<HomeProvider>().addresses.isNotEmpty) {
                  return ListView.separated(
                    itemCount: context.watch<HomeProvider>().addresses.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.black,
                        endIndent: 8,
                        indent: 8,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(context
                            .watch<HomeProvider>()
                            .addresses[index]
                            .addressName),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'noAddress'.tr(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
