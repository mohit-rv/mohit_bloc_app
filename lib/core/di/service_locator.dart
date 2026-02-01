import 'package:bloclearnbyproject/feature/data/repositories/auth_repository.dart';
import 'package:bloclearnbyproject/feature/data/repositories/post_repositories.dart';
import 'package:bloclearnbyproject/feature/data/repositories/product_repository.dart' hide AuthRepository;
import 'package:get_it/get_it.dart';
import 'package:bloclearnbyproject/core/network/api_client.dart';


final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ---------- API CLIENTS ----------
  sl.registerLazySingleton<ApiClient>(
        () => ApiClient(baseUrl: "https://jsonplaceholder.typicode.com"),
    instanceName: "jsonApi",
  );

  sl.registerLazySingleton<ApiClient>(
        () => ApiClient(baseUrl: "https://reqres.in/api"),
    instanceName: "authApi",
  );

  sl.registerLazySingleton<ApiClient>(
        () => ApiClient(baseUrl: "https://fakestoreapi.com"),
    instanceName: "productApi",
  );

  // ---------- REPOSITORIES ----------
  sl.registerLazySingleton<PostRepository>(
        () => PostRepository(
      apiClient: sl<ApiClient>(instanceName: "jsonApi"),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepository(
      apiClient: sl<ApiClient>(instanceName: "authApi"),
    ),
  );

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepository(
      apiClient: sl<ApiClient>(instanceName: "productApi"),
    ),
  );
}
