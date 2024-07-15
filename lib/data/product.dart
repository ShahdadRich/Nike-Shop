class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHighToLow = 2;
  static const int priceLowToHigh = 3;
}

class ProductEntity {
  final int id;
  final String title;
  final int price;
  final String imgUrl;
  final int discount;
  final int previousPrice;

  ProductEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        imgUrl = json['image'],
        discount = json['discount'],
        previousPrice = json['previous_price'] ?? json['price'];
}
