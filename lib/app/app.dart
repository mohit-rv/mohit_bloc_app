import 'package:bloclearnbyproject/app/app_routes.dart';
import 'package:bloclearnbyproject/core/di/service_locator.dart';
import 'package:bloclearnbyproject/core/network/api_client.dart';
import 'package:bloclearnbyproject/feature/data/repositories/auth_repository.dart';
import 'package:bloclearnbyproject/feature/data/repositories/post_repositories.dart';
import 'package:bloclearnbyproject/feature/data/repositories/product_repository.dart' hide AuthRepository;
import 'package:bloclearnbyproject/feature/presentetion/auth/auth_block/auth_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/cart/cart_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/post_list/post_block/post_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/product_detail/product_detail_block/product_detail_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/screen/post_list_screen/post_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bloc Master',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const PostListScreen(),
//     );
//   }
// }

//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final apiClient = ApiClient();
//     final repository = PostRepository(apiClient: apiClient);
//
//     return MaterialApp(
//       home: BlocProvider(
//         create: (context) => PostBloc(repository),
//         child: const PostListScreen1(),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final apiClient = ApiClient();
//     final repository = PostRepository(apiClient: apiClient);
//
//     return BlocProvider(
//       create: (_) => PostBloc(repository),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: AppRoutes.home,
//           routes: AppRoutes.routes
//       ),
//     );
//   }
// }


// login bnaane aur  lgane k bad aisa krna pdega

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // common ApiClient
//     final apiClient = ApiClient();
//
//     // repositories
//     final postRepo = PostRepository(apiClient: apiClient);
//     final authRepo = AuthRepository(apiClient: apiClient);
//
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => AuthBloc(repository: authRepo),
//         ),
//         BlocProvider(
//           create: (_) => PostBloc(postRepo),
//         ),
//
//         BlocProvider(
//           create: (_) => ProductBloc(ProductRepository(apiClient: apiClient)),
//         ),
//         BlocProvider(
//           create: (_) => CartBloc()
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: AppRoutes.home,   // ⭐ START APP FROM LOGIN
//         routes: AppRoutes.routes,        // ⭐ Clean simple route map
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(repository: sl<AuthRepository>()),
        ),
        BlocProvider(
          create: (_) => PostBloc(sl<PostRepository>()),
        ),
        BlocProvider(
          create: (_) => ProductBloc(sl<ProductRepository>()),
        ),
        BlocProvider(
          create: (_) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.mainscreen,
        routes: AppRoutes.routes,
      ),
    );
  }
}
