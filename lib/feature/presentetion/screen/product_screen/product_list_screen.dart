import 'package:bloclearnbyproject/feature/presentetion/product_detail/product_detail_block/product_detail_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/product_detail/product_detail_block/product_detail_event.dart';
import 'package:bloclearnbyproject/feature/presentetion/product_detail/product_detail_block/product_detail_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch all products from API
    context.read<ProductBloc>().add(FetchAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Products")),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          // Loader
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }

          // Loaded Product List
          if (state is ProductListLoaded) {
            final products = state.products;

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.59, // item height/width ratio
              ),
              itemBuilder: (context, index) {
                final p = products[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetailScreen(id: p.id),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // IMAGE
                          Center(
                            child: CachedNetworkImage(
                              imageUrl: p.image,
                                height: 120,
                                fit: BoxFit.cover,
                              placeholder: (context, url) => const  Center(
                                child: CupertinoActivityIndicator(
                                  color: Color.fromARGB(255, 2, 2, 2),
                                  radius: 10,
                                  animating: true,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.broken_image),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // TITLE
                          Text(
                            p.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // PRICE
                          Text(
                            "₹ ${p.price}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Spacer(),

                          // VIEW BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetailScreen(id: p.id),
                                  ),
                                );
                              },
                              child: const Text("View"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
