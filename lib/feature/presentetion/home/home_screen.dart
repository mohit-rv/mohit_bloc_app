import 'package:bloclearnbyproject/feature/presentetion/screen/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cart/cart_bloc.dart';
import '../cart/cart_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          buildCartBadge(context),   // <-- IMPORTANT
        ],
      ),

      body: const Center(
        child: Text(
          "Welcome to Home Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


/// ---------------------- CART BADGE WIDGET ----------------------
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

          if (count > 0)
            Positioned(
              right: 6,
              top: 6,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  "$count",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            )
        ],
      );
    },
  );
}
