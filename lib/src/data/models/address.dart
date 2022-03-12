import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'address.g.dart';

@HiveType(typeId: 5)
class Address {
  @HiveField(0)
  final String addressName;
  @HiveField(1)
  final String addressId;

  Address(this.addressName, this.addressId);
}
