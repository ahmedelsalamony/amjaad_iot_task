import 'package:amjaadiot_task/src/app/constants.dart';
import 'package:amjaadiot_task/src/app/routes/routes.dart';
import 'package:amjaadiot_task/src/business_logic/home_provider.dart';
import 'package:amjaadiot_task/src/presentation/shared_widgets/toggle_trl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool notificationStatus = false;
  bool locationStatus = false;
  bool isArabic = false;
  late HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('arabic'.tr()),
              Switch(
                value: homeProvider.getLang(),
                onChanged: (value) {
                  setState(() {
                    isArabic = value;
                    homeProvider.setLang(value);
                    if (isArabic) {
                      EasyLocalization.of(context)!
                          .setLocale(const Locale('en'));
                    } else {
                      EasyLocalization.of(context)!
                          .setLocale(const Locale('ar'));
                    }
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
                inactiveTrackColor: Colors.red,
                inactiveThumbColor: Colors.black,
              ),
              Text('english'.tr()),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(
            endIndent: 4,
            indent: 4,
            color: Colors.blueAccent,
          ),
          Row(
            children: [
              Text('notification'.tr()),
              Switch(
                value: homeProvider.getAllowNotificationValue(),
                onChanged: (value) async {
                  homeProvider.setAllowNotificationValue(value);
                  PermissionStatus permission =
                      await Permission.notification.request();
                  if (permission.isGranted) {
                    setState(() {
                      notificationStatus = value;
                      print(notificationStatus);
                    });
                  }
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(
            endIndent: 4,
            indent: 4,
            color: Colors.blueAccent,
          ),
          Row(
            children: [
              Text('location'.tr()),
              Switch(
                value: homeProvider.getAllowLocationValue(),
                onChanged: (value) async {
                  homeProvider.setAllowLocationValue(value);
                  PermissionStatus permission =
                      await Permission.locationWhenInUse.request();
                  if (permission.isGranted || permission.isLimited) {
                    locationStatus = value;
                  }
                  setState(() {
                    print(locationStatus);
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
          const Divider(
            endIndent: 4,
            indent: 4,
            color: Colors.blueAccent,
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.addresses);
            },
            child: Text(
              'addresses'.tr(),
            ),
          ),
        ],
      ),
    );
  }
}
