import 'package:dio/dio.dart';

// class ApiClient {
//   final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: 'https://jsonplaceholder.typicode.com',
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//     ),
//   );
// }




// class ApiClient {
//   final Dio _dio;
//   Dio get dio => _dio; // <-- ADD THIS GETTER
//
//   ApiClient()
//       : _dio = Dio(
//     BaseOptions(
//      // baseUrl: 'https://jsonplaceholder.typicode.com',
//      // baseUrl: 'https://reqres.in/api',
//       baseUrl: 'https://fakestoreapi.com',
//
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//     ),
//   );
//
//   Future<Response> get(
//       String path, {
//         Map<String, dynamic>? query,
//       }) async {
//     return await _dio.get(
//       path,
//       queryParameters: query,
//     );
//   }
// }


// for multiple base url


import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  Dio get dio => _dio;

  ApiClient({required String baseUrl})
      : _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Response> get(
      String path, {
        Map<String, dynamic>? query,
      }) async {
    return await _dio.get(
      path,
      queryParameters: query,
    );
  }

  Future<Response> post(
      String path, {
        Map<String, dynamic>? data,
      }) async {
    return await _dio.post(path, data: data);
  }

// zarurat pade to put/delete bhi add kar sakte ho
}

