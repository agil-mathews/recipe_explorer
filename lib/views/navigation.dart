import 'package:flutter/material.dart';
import 'package:recipe_explorer/views/favourite.dart';
import 'package:recipe_explorer/views/home.dart';
import 'package:recipe_explorer/views/search.dart';


class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    // SearchPage(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.35 : 0.05),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: theme.colorScheme.surface,
          indicatorColor: theme.colorScheme.primary.withOpacity(0.12),
          height: 72,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined, 
                color: theme.colorScheme.onSurface.withOpacity(0.5)
              ),
              selectedIcon: Icon(
                Icons.home_rounded, 
                color: theme.colorScheme.primary,
                size: 26,
              ),
              label: 'Home',
            ),
            // NavigationDestination(
            //   icon: Icon(
            //     Icons.search_rounded, 
            //     color: theme.colorScheme.onSurface.withOpacity(0.5)
            //   ),
            //   selectedIcon: Icon(
            //     Icons.search_rounded, 
            //     color: theme.colorScheme.primary,
            //     size: 26,
            //   ),
            //   label: 'Search',
            // ),
            NavigationDestination(
              icon: Icon(
                Icons.favorite_outline_rounded, 
                color: theme.colorScheme.onSurface.withOpacity(0.5)
              ),
              selectedIcon: Icon(
                Icons.favorite_rounded, 
                color: theme.colorScheme.primary,
                size: 26,
              ),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
