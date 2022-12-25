import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tico_apps/constant.dart';
import 'package:tico_apps/presentation/home/home_page.dart';
import 'package:tico_apps/presentation/profile/profile_page.dart';
import 'package:tico_apps/presentation/task/task_page.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation();

  @override
  State<PageNavigation> createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation> {
  int _selectedNavbar = 0;

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetPage = [
      HomePage(),
      TaskPage(),
      ProfilePage(),
    ];
    return new Scaffold(
      body: SafeArea(
        child: widgetPage.elementAt(_selectedNavbar),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/icons/home_blue.svg',
                color: LIGHT_BLUE,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset('assets/icons/home.svg'),
            ),
            label: 'beranda',
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/icons/task_blue.svg',
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset('assets/icons/task.svg'),
            ),
            label: 'tugas',
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/icons/profile_blue.svg',
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset('assets/icons/profile.svg'),
            ),
            label: 'profil',
          ),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: LIGHT_BLUE,
        unselectedItemColor: DARK_GRAY,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavbar,
      ),
    );
  }
}
