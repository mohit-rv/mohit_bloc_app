
import 'package:meta/meta.dart';

@immutable
sealed class ProductEvent {}

/// Fetch list of all products
class FetchAllProducts extends ProductEvent {}

/// Fetch single product detail
class FetchProductDetail extends ProductEvent {
  final int id;
  FetchProductDetail(this.id);
}

