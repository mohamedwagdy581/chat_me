import 'package:chat_me/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();

  ApplicationController();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTaps;


  void handPageChanged(int index)
  {
    state.page = index;
  }

  void handelNavBarTap(int index)
  {
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    tabTitles = ['Chat', 'Contact', 'Profile'];
    bottomTaps = <BottomNavigationBarItem>[

      // Chat BottomNavItem
      customBottomNavItem(icon: Icons.message, label: 'Chat'),

      // Contacts BottomNavItem
      customBottomNavItem(icon: Icons.contact_page, label: 'Contacts'),

      // Profile BottomNavItem
      customBottomNavItem(icon: Icons.person, label: 'Profile'),
    ];

    pageController = PageController(initialPage: state.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

}

// Custom BottomNavigationBarItem Widget
BottomNavigationBarItem customBottomNavItem({required IconData icon, required String label}) => BottomNavigationBarItem(
  icon: Icon(
    icon,
    color: AppColors.thirdElementText,
  ),
  activeIcon: Icon(
    icon,
    color: AppColors.secondaryElementText,
  ),
  label: label,
  backgroundColor: AppColors.primaryBackground,
);

