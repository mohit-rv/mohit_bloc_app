import 'package:bloclearnbyproject/feature/presentetion/home/home_screen.dart';
import 'package:bloclearnbyproject/feature/presentetion/screen/login_screen/login_screen.dart';
import 'package:bloclearnbyproject/feature/presentetion/screen/post_list_screen/post_list_screen.dart';
import 'package:flutter/material.dart';

import '../feature/presentetion/screen/bottom_nav_screen/bottom_nav_screen.dart';

// class AppRoutes {
//   static const String home = '/';
//   static const String posts = '/posts';
//
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case home:
//         return MaterialPageRoute(
//           builder: (_) => const PostListScreen3(), // default HOME
//         );
//
//       case posts:
//         return MaterialPageRoute(
//           builder: (_) => const PostListScreen4(),
//         );
//
//       default:
//         return MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(child: Text("Route not found")),
//           ),
//         );
//     }
//   }
// }


class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String mainscreen = '/main';


  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    mainscreen: (context) => const BottomNavScreen(),
  };
}