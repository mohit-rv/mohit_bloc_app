
import 'package:bloclearnbyproject/feature/data/model/cart_model.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class CartState {}

// 🔵 When app starts OR cart is empty
class CartInitialState extends CartState {}

// 🟢 When cart has data
class CartLoadedState extends CartState {
  final List<CartItem> items;
  final double total;

  CartLoadedState({
    required this.items,
    required this.total,
  });
}

// 🔴 If something failed (optional)
class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message);
}

