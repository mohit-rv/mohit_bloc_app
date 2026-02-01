import 'package:bloclearnbyproject/feature/presentetion/cart/cart_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/cart/cart_state.dart';
import 'package:bloclearnbyproject/feature/presentetion/screen/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildCartBadge(BuildContext context) {
  return BlocBuilder<CartBloc, CartState>(
    builder: (context, state) {
      int count = 0;

      if (state is CartLoadedState) {
        count = state.items.length;
      }

      return Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),

          // ---- Badge ----
          if (count > 0)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$count",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      );
    },
  );
}



Widget buildCartBadgeBottomNav(BuildContext context) {
  return BlocBuilder<CartBloc, CartState>(
    builder: (context, state) {
      int count = 0;

      if (state is CartLoadedState) {
        count = state.items.length;
      }

      return Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.shopping_cart),

          if (count > 0)
            Positioned(
              right: 0,
              top: 3,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
                child: Text(
                  "$count",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      );
    },
  );
}