import 'package:nike/data/cart_item.dart';

class CartResponse {
  final List<CartItemEntity> cartItems;
  final int payableprice;
  final int totalPrice;
  final int shippingCost;

  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItems = CartItemEntity.pasreJsonArray(
          json['cart_items'],
        ),
        payableprice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingCost = json['shipping_cost'];
}
