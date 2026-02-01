import 'package:bloclearnbyproject/feature/presentetion/cart/cart_bloc.dart';
import 'package:bloclearnbyproject/feature/presentetion/cart/cart_event.dart';
import 'package:bloclearnbyproject/feature/presentetion/home/home_screen.dart';
import 'package:bloclearnbyproject/feature/presentetion/screen/cart_screen/cart_screen.dart';
import 'package:bloclearnbyproject/feature/presentetion/screen/product_screen/product_list_screen.dart';
import 'package:bloclearnbyproject/feature/presentetion/screen/profile_screen/profile_screen.dart';
import 'package:bloclearnbyproject/feature/presentetion/widget/cart_badge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 // if required

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final screens = const [
    HomeScreen(),
    ProductListScreen(),
    CartScreen(),
     ProfileScreen(),  // <-- Uncomment only when ready
  ];


  BottomNavigationBarItem _navItem(
      IconData icon,
      String label,
      int index,
      ) {
    return BottomNavigationBarItem(
      icon: _animatedIcon(
        Icon(icon),
        index,
      ),
      label: label,
    );
  }


  Widget _animatedIcon(Widget icon, int index) {
    final isSelected = _currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: EdgeInsets.all(isSelected ? 10 : 6),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.deepPurple.withOpacity(0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AnimatedScale(
        scale: isSelected ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 250),
        child: icon,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // App start par 1 hi baar load hoga (best practice)
    context.read<CartBloc>().add(LoadCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 12,
            unselectedFontSize: 11,

            onTap: (i) {
              if (i < screens.length) {
                setState(() => _currentIndex = i);
              }
            },

            items: [
              _navItem(Icons.home, "Home", 0),
              _navItem(Icons.list, "Products", 1),

              BottomNavigationBarItem(
                icon: _animatedIcon(
                  buildCartBadgeBottomNav(context),
                  2,
                ),
                label: "Cart",
              ),

              _navItem(Icons.person, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }




}
