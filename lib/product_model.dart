class Product {
  String? productName;
  String? productDescription;
  String? productImage;
  String? qrCodeID;
  String? userName;
  String? marketName;
  String? addedDate;
  String? price;
  Product(
      this.productName,
      this.qrCodeID,
      this.productDescription,
      this.productImage,
      this.userName,
      this.addedDate,
      this.marketName,
      this.price);
}

class MyUser {
  String userName;
  List<String> favoriProducts;
  MyUser(this.userName, this.favoriProducts);
}

class ProductModelConverter {
  Product productModelFromJson(Map<String, dynamic>? json) => Product(
      json?["productName"],
      json?["qrCode"],
      json?["productDescription"],
      json?["productImage"],
      json?["userName"],
      json?["addedDate"],
      json?["marketName"],
      json?["price"]);

  Map<String, dynamic> productModelToJson(Product instance) =>
      <String, dynamic>{
        'productName': instance.productName,
        'productDescription': instance.productDescription,
        'productImage': instance.productImage,
        'qrCodeID': instance.qrCodeID,
        'price': instance.price,
        'addedDate': instance.addedDate,
        'marketName': instance.marketName,
        'userName': instance.userName,
      };
}
