class ReceiptModel {
  final int id;
  final String marketName;
  final String marketBranch;
  final DateTime dateTime;
  final int totalQuantity;
  final bool favorite;
  final List<ProductModel> products;

  ReceiptModel({
    required this.id,
    required this.marketName,
    required this.marketBranch,
    required this.dateTime,
    required this.totalQuantity,
    this.favorite = false,
    required this.products,
  });

  ReceiptModel copyWith({
    int? id,
    String? marketName,
    String? marketBranch,
    DateTime? dateTime,
    int? totalQuantity,
    bool? favorite,
    List<ProductModel>? products,
  }) {
    return ReceiptModel(
      id: id ?? this.id,
      marketName: marketName ?? this.marketName,
      marketBranch: marketBranch ?? this.marketBranch,
      dateTime: dateTime ?? this.dateTime,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      favorite: favorite ?? this.favorite,
      products: products ?? this.products,
    );
  }

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<ProductModel> productsList =
        productList.map((i) => ProductModel.fromJson(i)).toList();

    return ReceiptModel(
      id: json['receiptId'],
      marketName: json['marketName'],
      marketBranch: json['marketBranch'],
      dateTime: DateTime.parse(json['dateTime']),
      totalQuantity: json['totalQuantity'],
      favorite: json['favorite'] ?? false,
      products: productsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiptId': id,
      'marketName': marketName,
      'marketBranch': marketBranch,
      'dateTime': dateTime.toIso8601String(),
      'totalQuantity': totalQuantity,
      'favorite': favorite,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }
}

class ProductModel {
  final String productName;
  final int productPiece;
  final double kdvRate;

  ProductModel({
    required this.productName,
    required this.productPiece,
    required this.kdvRate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['productName'],
      productPiece: json['productPiece'],
      kdvRate: json['kdvRate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productPiece': productPiece,
      'kdvRate': kdvRate,
    };
  }
}
