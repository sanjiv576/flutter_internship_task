import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_view.dart';
import 'singel_product_view.dart';

// select index as the user clicks
final selectedIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigationView extends ConsumerStatefulWidget {
  const BottomNavigationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomNavigationViewState();
}

class _BottomNavigationViewState extends ConsumerState<BottomNavigationView> {
  void _onTapItem(int index) {
    ref.watch(selectedIndexProvider.notifier).state = index;
  }

  // all  widgets in a list

  final List<Widget> _screens = [
    const HomeView(),
    const SingleProductView(),
  ];


  // style for botttom navigation bar
  final List<CurvedNavigationBarItem> _navigationIcons = [
    const CurvedNavigationBarItem(
        label: 'Home',
        labelStyle: TextStyle(color: Colors.black),

        child: Icon(
          Icons.home,
          color: Colors.black,
        )),
    const CurvedNavigationBarItem(
        label: 'Shopping',
        labelStyle: TextStyle(color: Colors.black),
        child: Icon(
          Icons.person,
          color: Colors.black,

        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          items: _navigationIcons,
          index: ref.watch(selectedIndexProvider),
          onTap: _onTapItem,

          backgroundColor: Colors.black,
          animationCurve: Curves.easeInSine,
          animationDuration: const Duration(milliseconds: 300),
        ),
        body: _screens.elementAt(ref.watch(selectedIndexProvider)));
  }
}
