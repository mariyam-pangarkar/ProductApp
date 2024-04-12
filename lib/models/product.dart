class Productgenerate {
  Productgenerate({
    required this.id,
    required this.name,
    required this.moq,
    required this.price,
    required this.discountedPrice,
  });
  late final String id;
  late final String name;
  late final String moq;
  late final String price;
  late final String discountedPrice;

  Productgenerate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moq = json['moq'];
    price = json['price'];
    discountedPrice = json['discounted_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['moq'] = moq;
    _data['price'] = price;
    _data['discounted_price'] = discountedPrice;
    return _data;
  }
}
