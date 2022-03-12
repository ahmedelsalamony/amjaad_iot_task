import 'package:amjaadiot_task/src/app/app_themes.dart';
import 'package:amjaadiot_task/src/app/constants.dart';
import 'package:amjaadiot_task/src/app/routes/route_generator.dart';
import 'package:amjaadiot_task/src/business_logic/home_provider.dart';
import 'package:amjaadiot_task/src/data/repository/home_repo.dart';
import 'package:amjaadiot_task/src/presentation/screens/home/home_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppThemes.light();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider(HomeRepo())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: theme,
        initialRoute: Routes.home,
        onGenerateRoute: (settings) {
          return RouteGenerator.generateRoute(settings);
        },
        title: 'appTitle'.tr(),
      ),
    );
  }
}
