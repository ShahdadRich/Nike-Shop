import 'package:nike/data/product.dart';

class CartItemEntity {
  final ProductEntity product;
  final int id;
  final int count;

  CartItemEntity.fromJson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json['product']),
        id = json['cart_item_id'],
        count = json['count'];

  static List<CartItemEntity> pasreJsonArray(List<dynamic> jsonArray) {
    final List<CartItemEntity> cartItem = [];
    jsonArray.forEach((element) {
      cartItem.add(CartItemEntity.fromJson(element));
    });
    return cartItem;
  }
}
