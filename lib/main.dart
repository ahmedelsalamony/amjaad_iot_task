import 'package:amjaadiot_task/src/app/my_app.dart';
import 'package:amjaadiot_task/src/data/models/address.dart';
import 'package:amjaadiot_task/src/data/models/product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(AddressAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ErrorWidget.builder = ((FlutterErrorDetails e) {
    return Center(
      child: Text(e.exceptionAsString()),
    );
  });
  runApp(EasyLocalization(
      path: 'lib/public/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      child: const MyApp()));
}
