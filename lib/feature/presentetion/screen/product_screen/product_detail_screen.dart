import 'package:bloclearnbyproject/feature/presentetion/cart/cart_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/cart/cart_event.dart';
import 'package:bloclearnbyproject/feature/presentetion/product_detail/product_detail_block/product_detail_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/product_detail/product_detail_block/product_detail_event.dart';
import 'package:bloclearnbyproject/feature/presentetion/product_detail/product_detail_block/product_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductDetailScreen extends StatelessWidget {
  final int id;

  const ProductDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // Fetch product detail
    context.read<ProductBloc>().add(FetchProductDetail(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
        centerTitle: true,
      ),

      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          // ----- LOADING -----
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ----- ERROR -----
          if (state is ProductError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }

          // ----- SUCCESS -----
          if (state is ProductDetailLoaded) {
            final p = state.product;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PRODUCT IMAGE
                  Center(
                    child: Image.network(
                      p.image,
                      height: 260,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // TITLE
                  Text(
                    p.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // PRICE
                  Text(
                    "₹ ${p.price}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // DESCRIPTION
                  Text(
                    p.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 40),

                  // ADD TO CART BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Module-5 (Part-2) → CartBloc integration
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Added to cart (soon real)!")),
                        );
                      },
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}


// product detail screen  cart add k bad


class ProductDetailCartScreen extends StatelessWidget {
  final int id;

  const ProductDetailCartScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // Fetch product detail
    context.read<ProductBloc>().add(FetchProductDetail(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
        centerTitle: true,
      ),

      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          // ----- LOADING -----
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ----- ERROR -----
          if (state is ProductError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }

          // ----- SUCCESS -----
          if (state is ProductDetailLoaded) {
            final p = state.product;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PRODUCT IMAGE
                  Center(
                    child: Image.network(
                      p.image,
                      height: 260,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // TITLE
                  Text(
                    p.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // PRICE
                  Text(
                    "₹ ${p.price}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // DESCRIPTION
                  Text(
                    p.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 40),

                  // 🔥 ADD TO CART BUTTON (REAL)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(AddToCartEvent(p));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to cart"),
                          ),
                        );
                      },
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
