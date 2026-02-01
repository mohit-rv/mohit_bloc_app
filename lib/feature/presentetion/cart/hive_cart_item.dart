import 'package:hive/hive.dart';
part 'hive_cart_item.g.dart';

@HiveType(typeId: 1)
class HiveCartItem {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final int qty;

  HiveCartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.qty,
  });
}


//flutter pub run build_runner build
//dart run build_runner build
//dart run build_runner build --delete-conflicting-outputs
// ye commond chlana jruri hai iske bad