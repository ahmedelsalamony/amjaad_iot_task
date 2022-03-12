import 'package:amjaadiot_task/src/business_logic/home_provider.dart';
import 'package:amjaadiot_task/src/presentation/screens/home/products/products_screen.dart';
import 'package:amjaadiot_task/src/presentation/screens/home/profile/profile.dart';
import 'package:amjaadiot_task/src/presentation/shared_widgets/cart_icon.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../app/constants.dart';
import '../../../app/routes/routes.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Hive.openBox(Constants.appConfigBoxName);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
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
      body: PageView(controller: _pageController, children: [
        const ProductsScreen(),
        const Profile(),
      ]),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
          _pageController!.jumpToPage(index);
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: Text('home'.tr()),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: Text('profile'.tr()),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
