import 'package:chat_me/common/values/colors.dart';
import 'package:chat_me/pages/contacts/index.dart';
import 'package:chat_me/pages/message/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../profile/view.dart';
import 'controller.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.handPageChanged,
      children: const [
        MessagePage(),
        ContactPage(),
        ProfilePage(),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        items: controller.bottomTaps,
        currentIndex: controller.state.page,
        type: BottomNavigationBarType.fixed,
        onTap: controller.handelNavBarTap,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: AppColors.tabBarElement,
        selectedItemColor: AppColors.thirdElementText,
      ),
    );
  }
}
