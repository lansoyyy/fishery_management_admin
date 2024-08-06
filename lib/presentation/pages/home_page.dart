import 'package:fishery_management_admin/presentation/pages/tabs/farmer_tab.dart';
import 'package:fishery_management_admin/presentation/pages/tabs/fish_tab.dart';
import 'package:fishery_management_admin/presentation/pages/tabs/temp_tab.dart';
import 'package:fishery_management_admin/presentation/utils/colors.dart';
import 'package:fishery_management_admin/presentation/widgets/appbar_widget.dart';
import 'package:fishery_management_admin/presentation/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final tabs = [const FishTab(), const TempTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Home'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7.5),
          child: BottomNavigationBar(
              backgroundColor: secondaryColor,
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.shifting,
              selectedLabelStyle: const TextStyle(
                color: Colors.white,
              ),
              unselectedLabelStyle: const TextStyle(
                color: Colors.white,
              ),
              onTap: (int newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              },
              selectedItemColor: Colors.white,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: secondaryColor,
                  icon: Image.asset(
                    'assets/images/logo.png',
                    color: Colors.white,
                    height: 30,
                  ),
                  label: 'Soils',
                ),
                BottomNavigationBarItem(
                  backgroundColor: secondaryColor,
                  icon: Image.asset(
                    'assets/images/temp.png',
                    color: Colors.white,
                    height: 30,
                  ),
                  label: 'Temperatures',
                )
              ]),
        ),
      ),
      body: tabs[_currentIndex],
    );
  }
}
