import 'package:bloclearnbyproject/feature/data/model/product_model/prodict_model.dart';



class CartItem {
  final ProductModel product;
  final int qty; // <- isko final rakho, immutable design

  CartItem({
    required this.product,
    required this.qty,
  });

  // 👉 yahi wo method hai jo missing tha
  CartItem copyWith({
    ProductModel? product,
    int? qty,
  }) {
    return CartItem(
      product: product ?? this.product,
      qty: qty ?? this.qty,
    );
  }
}

