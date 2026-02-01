import 'package:bloclearnbyproject/feature/data/repositories/product_repository.dart';
import 'package:bloclearnbyproject/feature/presentetion/product_detail/product_detail_block/product_detail_event.dart';
import 'package:bloclearnbyproject/feature/presentetion/product_detail/product_detail_block/product_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<FetchAllProducts>(_onFetchAllProducts);
    on<FetchProductDetail>(_onFetchProductDetail);
  }

  // ------------------------------------------------
  // 🔹 Fetch All Products (List Screen)
  // ------------------------------------------------
  Future<void> _onFetchAllProducts(
      FetchAllProducts event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());
    try {
      final products = await repository.getProducts();
      emit(ProductListLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to fetch product list"));
    }
  }

  // ------------------------------------------------
  // 🔹 Fetch Single Product Detail
  // ------------------------------------------------
  Future<void> _onFetchProductDetail(
      FetchProductDetail event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());
    try {
      final product = await repository.getProductById(event.id);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductError("Failed to load product detail"));
    }
  }
}
