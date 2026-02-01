import 'package:bloclearnbyproject/feature/presentetion/cart/cart_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/cart/cart_event.dart';
import 'package:bloclearnbyproject/feature/presentetion/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),

      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {

          // ---------- EMPTY CART ----------
          if (state is CartInitialState) {
            return const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // ---------- CART WITH ITEMS ----------
          if (state is CartLoadedState) {
            final items = state.items;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final item = items[i];

                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            item.product.image,
                            width: 60,
                            fit: BoxFit.cover,
                          ),

                          title: Text(item.product.title),
                          subtitle: Text("₹ ${item.product.price}"),

                          // Qty Row: -    2    +
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ----------------- MINUS BUTTON -----------------
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(DecreaseQtyEvent(item.product));
                                },
                              ),

                              Text("${item.qty}", style: const TextStyle(fontSize: 18)),

                              // ----------------- PLUS BUTTON -----------------
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(IncreaseQtyEvent(item.product));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ------------ TOTAL PRICE ------------
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Text(
                    "Total: ₹ ${state.total.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
