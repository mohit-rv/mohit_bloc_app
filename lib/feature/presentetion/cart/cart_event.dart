import 'package:bloclearnbyproject/feature/data/model/product_model/prodict_model.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class CartEvent {}

// Add product to cart
class AddToCartEvent extends CartEvent {
  final ProductModel product;
  AddToCartEvent(this.product);
}

// Remove completely from cart
class RemoveFromCartEvent extends CartEvent {
  final ProductModel product;
  RemoveFromCartEvent(this.product);
}

// Increase quantity (+)
class IncreaseQtyEvent extends CartEvent {
  final ProductModel product;
  IncreaseQtyEvent(this.product);
}

// Decrease quantity (-)
class DecreaseQtyEvent extends CartEvent {
  final ProductModel product;
  DecreaseQtyEvent(this.product);
}

// Remove all items
class ClearCartEvent extends CartEvent {}
class LoadCartEvent extends CartEvent {}
