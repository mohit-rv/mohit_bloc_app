import 'package:bloclearnbyproject/app/app.dart';
import 'package:bloclearnbyproject/app/block_observer.dart';
import 'package:bloclearnbyproject/core/di/service_locator.dart';
import 'package:bloclearnbyproject/feature/presentetion/cart/hive_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();        // ✔ ALWAYS FIRST
//
//   await Hive.initFlutter();                         // ✔ Hive start
//
//   Hive.registerAdapter(HiveCartItemAdapter());      // ✔ Register adapter
//
//   await Hive.openBox<HiveCartItem>('cartBox');      // ✔ Open cart box
//
//   Bloc.observer = AppBlocObserver();                // ✔ BLoC observer
//
//   runApp(const MyApp());                            // ✔ Start app
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(HiveCartItemAdapter());
  await Hive.openBox<HiveCartItem>('cartBox');

  // DI init
  await initDependencies();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}