import 'package:bloclearnbyproject/feature/data/model/product_model/prodict_model.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ProductState {}

/// Initial state
class ProductInitial extends ProductState {}

/// Loading state for both list and detail
class ProductLoading extends ProductState {}

/// Loaded list of products
class ProductListLoaded extends ProductState {
  final List<ProductModel> products;

  ProductListLoaded(this.products);
}

/// Loaded detail of a single product
class ProductDetailLoaded extends ProductState {
  final ProductModel product;

  ProductDetailLoaded(this.product);
}

/// Error handling
class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
