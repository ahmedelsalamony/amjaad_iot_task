import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ToggleRTL extends StatefulWidget {
  const ToggleRTL({Key? key}) : super(key: key);

  @override
  _ToggleRTLState createState() => _ToggleRTLState();
}

class _ToggleRTLState extends State<ToggleRTL> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.green.withOpacity(0.5),
        child: ToggleButtons(
          isSelected: isSelected,
          selectedColor: Colors.white,
          color: Colors.black,
          fillColor: Colors.lightBlue.shade900,
          renderBorder: false,
          //splashColor: Colors.red,
          highlightColor: Colors.orange,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('arabic'.tr(), style: const TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('english'.tr(), style: const TextStyle(fontSize: 18)),
            )
          ],
          onPressed: (int newIndex) {
            setState(() {
              for (int index = 0; index < isSelected.length; index++) {
                if (index == newIndex) {
                  isSelected[index] = true;
                } else {
                  isSelected[index] = false;
                }
              }
            });
          },
        ),
      );
}
