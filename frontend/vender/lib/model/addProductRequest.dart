class AddProductRequest {
  final String userId;
  final String productType;
  final String productName;
  final String productPrice;
  final String productStock;
  final String productImage;
  final String productOfferPrice;

  AddProductRequest({
    required this.userId,
    required this.productType,
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productImage,
    required this.productOfferPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productType': productType,
      'productName': productName,
      'productPrice': productPrice,
      'productStock': productStock,
      'productImage': productImage,
      'productOfferPrice': productOfferPrice,
    };
  }
}
