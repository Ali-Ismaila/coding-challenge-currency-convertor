import 'package:hive/hive.dart';

part 'country_data.g.dart';

@HiveType(typeId: 1)
class CountryData {
  @HiveField(0)
  String currencyId;
  @HiveField(1)
  String currencyName;
  @HiveField(2)
  String currencySymbol;
  @HiveField(3)
  String id;
  @HiveField(4)
  String name;
  @HiveField(5)
  String image;

  CountryData(
      {required this.currencyId,
      required this.currencyName,
      required this.currencySymbol,
      required this.id,
      required this.name,
      required this.image});
}
