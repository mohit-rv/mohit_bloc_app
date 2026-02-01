import 'package:bloclearnbyproject/core/network/api_client.dart';
import 'package:bloclearnbyproject/core/network/api_endpoint.dart';
import 'package:bloclearnbyproject/feature/data/model/post_list_model/post_model.dart';

// class PostRepository {
//   final ApiClient apiClient;
//
//   PostRepository({required this.apiClient});
//
//   // -----------------------------------------
//   // postlistscreen2 aur 1 ke liye (OLD version)
//   // Ye code aapke reference ke liye rakha gaya hai 👇
//   //
//   // Future<List<PostModel>> getPosts() async {
//   //   final response = await apiClient.get('/posts');
//   //   final List data = response.data;
//   //   return data.map((json) => PostModel.fromJson(json)).toList();
//   // }
//   // -----------------------------------------
//
//
//   // -----------------------------------------
//   // NEW VERSION — Pagination + Refresh ke liye
//   // -----------------------------------------
//   Future<List<PostModel>> getPosts({
//     int page = 1,
//     int limit = 20,
//   }) async {
//     final response = await apiClient.get(
//       ApiEndpoints.posts,
//       query: {
//         "_page": page,
//         "_limit": limit,
//       },
//     );
//
//     final List data = response.data;
//     return data.map((e) => PostModel.fromJson(e)).toList();
//   }
//
//
//   // -----------------------------------------
//   // SEARCH POSTS (search + debounce support)
//   // -----------------------------------------
//   Future<List<PostModel>> searchPosts(String text) async {
//     final response = await apiClient.get(
//       ApiEndpoints.posts,
//       query: {
//         "q": text, // JSONPlaceholder search filter
//       },
//     );
//
//     final List data = response.data;
//     return data.map((e) => PostModel.fromJson(e)).toList();
//   }
// }



import 'package:bloclearnbyproject/core/network/api_client.dart';
import 'package:bloclearnbyproject/core/network/api_endpoint.dart';
import '../model/post_list_model/post_model.dart';

class PostRepository {
  final ApiClient apiClient;

  PostRepository({required this.apiClient});

  // ------------------------------------------------------
  // GET POSTS (Pagination Support)
  // ------------------------------------------------------
  Future<List<PostModel>> getPosts({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await apiClient.dio.get(
        ApiEndpoints.posts,
        queryParameters: {
          "_page": page,
          "_limit": limit,
        },
      );

      final List data = response.data;
      return data.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load posts");
    }
  }

  // ------------------------------------------------------
  // SEARCH POSTS (Search + Debounce Support)
  // ------------------------------------------------------
  Future<List<PostModel>> searchPosts(String query) async {
    try {
      final response = await apiClient.dio.get(
        ApiEndpoints.posts,
        queryParameters: {
          "q": query,
        },
      );

      final List data = response.data;
      return data.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Search failed");
    }
  }
}

