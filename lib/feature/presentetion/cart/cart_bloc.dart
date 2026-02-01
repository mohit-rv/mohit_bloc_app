import 'package:bloc/bloc.dart';
import 'package:bloclearnbyproject/feature/data/model/cart_model.dart';
import 'package:bloclearnbyproject/feature/data/model/product_model/prodict_model.dart';
import 'package:bloclearnbyproject/feature/presentetion/cart/cart_state.dart';
import 'package:bloclearnbyproject/feature/presentetion/cart/hive_cart_item.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';


// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc() : super(CartInitialState()) {
//
//     // ADD TO CART
//     on<AddToCartEvent>((event, emit) {
//       final currentState = state;
//
//       List<CartItem> updatedItems = [];
//
//       if (currentState is CartLoadedState) {
//         updatedItems = List<CartItem>.from(currentState.items);
//       }
//
//       final index = updatedItems.indexWhere((i) => i.product.id == event.product.id);
//
//       if (index >= 0) {
//         updatedItems[index] =
//             updatedItems[index].copyWith(qty: updatedItems[index].qty + 1);
//       } else {
//         updatedItems.add(CartItem(product: event.product, qty: 1));
//       }
//
//       emit(CartLoadedState(
//         items: updatedItems,
//         total: _calculateTotal(updatedItems),
//       ));
//     });
//
//     // REMOVE COMPLETELY
//     on<RemoveFromCartEvent>((event, emit) {
//       final currentState = state;
//
//       if (currentState is CartLoadedState) {
//         final updatedItems = List<CartItem>.from(currentState.items)
//           ..removeWhere((i) => i.product.id == event.product.id);
//
//         if (updatedItems.isEmpty) {
//           emit(CartInitialState());
//         } else {
//           emit(CartLoadedState(
//             items: updatedItems,
//             total: _calculateTotal(updatedItems),
//           ));
//         }
//       }
//     });
//
//     // INCREASE QTY
//     on<IncreaseQtyEvent>((event, emit) {
//       final currentState = state;
//
//       if (currentState is CartLoadedState) {
//         final updatedItems = List<CartItem>.from(currentState.items);
//
//         final index = updatedItems.indexWhere((i) => i.product.id == event.product.id);
//
//         if (index >= 0) {
//           updatedItems[index] =
//               updatedItems[index].copyWith(qty: updatedItems[index].qty + 1);
//         }
//
//         emit(CartLoadedState(
//           items: updatedItems,
//           total: _calculateTotal(updatedItems),
//         ));
//       }
//     });
//
//     // DECREASE QTY
//     on<DecreaseQtyEvent>((event, emit) {
//       final currentState = state;
//
//       if (currentState is CartLoadedState) {
//         final updatedItems = List<CartItem>.from(currentState.items);
//
//         final index = updatedItems.indexWhere((i) => i.product.id == event.product.id);
//
//         if (index >= 0) {
//           if (updatedItems[index].qty > 1) {
//             updatedItems[index] =
//                 updatedItems[index].copyWith(qty: updatedItems[index].qty - 1);
//           } else {
//             updatedItems.removeAt(index);
//           }
//         }
//
//         if (updatedItems.isEmpty) {
//           emit(CartInitialState());
//         } else {
//           emit(CartLoadedState(
//             items: updatedItems,
//             total: _calculateTotal(updatedItems),
//           ));
//         }
//       }
//     });
//
//     // CLEAR CART
//     on<ClearCartEvent>((event, emit) {
//       emit(CartInitialState());
//     });
//   }
//
//   double _calculateTotal(List<CartItem> items) {
//     return items.fold(0, (sum, item) => sum + (item.product.price * item.qty));
//   }
// }


// hive lgane k bad



class CartBloc extends Bloc<CartEvent, CartState> {
  final Box<HiveCartItem> box = Hive.box<HiveCartItem>('cartBox');

  CartBloc() : super(CartInitialState()) {
    // --------------- LOAD CART FROM HIVE ON STARTUP ---------------
    on<LoadCartEvent>((event, emit) {
      final hiveItems = box.values.toList();

      if (hiveItems.isEmpty) {
        emit(CartInitialState());
        return;
      }

      final cartItems = hiveItems
          .map((h) => CartItem(
        product: ProductModel(
          id: h.productId,
          title: h.title,
          price: h.price,
          description: "",           // ✔ required field filled
          image: h.image,
        ),
        qty: h.qty,
      ))
          .toList();

      emit(CartLoadedState(
        items: cartItems,
        total: _calculateTotal(cartItems),
      ));
    });

    // ------------------- ADD TO CART -------------------
    on<AddToCartEvent>((event, emit) {
      List<CartItem> items = _currentItems();

      final index = items.indexWhere((i) => i.product.id == event.product.id);

      if (index >= 0) {
        items[index] = items[index].copyWith(qty: items[index].qty + 1);
      } else {
        items.add(CartItem(product: event.product, qty: 1));
      }

      _saveToHive(items);

      emit(CartLoadedState(items: items, total: _calculateTotal(items)));
    });

    // ------------------- INCREASE QTY -------------------
    on<IncreaseQtyEvent>((event, emit) {
      List<CartItem> items = _currentItems();

      final index = items.indexWhere((i) => i.product.id == event.product.id);

      if (index >= 0) {
        items[index] =
            items[index].copyWith(qty: items[index].qty + 1);
      }

      _saveToHive(items);

      emit(CartLoadedState(items: items, total: _calculateTotal(items)));
    });

    // ------------------- DECREASE QTY -------------------
    on<DecreaseQtyEvent>((event, emit) {
      List<CartItem> items = _currentItems();

      final index = items.indexWhere((i) => i.product.id == event.product.id);

      if (index >= 0) {
        if (items[index].qty > 1) {
          items[index] =
              items[index].copyWith(qty: items[index].qty - 1);
        } else {
          items.removeAt(index);
        }
      }

      _saveToHive(items);

      if (items.isEmpty) {
        emit(CartInitialState());
      } else {
        emit(CartLoadedState(items: items, total: _calculateTotal(items)));
      }
    });

    // ------------------- CLEAR CART -------------------
    on<ClearCartEvent>((event, emit) {
      box.clear();
      emit(CartInitialState());
    });
  }

  // ------------------- UTIL METHODS -------------------

  List<CartItem> _currentItems() {
    if (state is CartLoadedState) {
      return List<CartItem>.from((state as CartLoadedState).items);
    }
    return [];
  }

  void _saveToHive(List<CartItem> items) {
    box.clear();
    for (var item in items) {
      box.add(HiveCartItem(
        productId: item.product.id,
        title: item.product.title,
        price: item.product.price,
        image: item.product.image,
        qty: item.qty,
      ));
    }
  }

  double _calculateTotal(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + (item.product.price * item.qty));
  }
}

