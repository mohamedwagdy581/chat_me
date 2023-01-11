import 'package:chat_me/common/entities/entities.dart';
import 'package:chat_me/common/values/colors.dart';
import 'package:chat_me/common/widgets/app.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controller.dart';
import 'widgets/head_item.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
              sliver: SliverToBoxAdapter(
                child: controller.state.head_detail.value == null
                    ? Container()
                : headItem(controller.state.head_detail.value!),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var item = controller.state.meListItem[index];
                    return myItem(item);
                  },
                  childCount: controller.state.meListItem.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return transparentAppBar(
      title: Text(
        'Profile',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryBackground,
        ),
      ),
    );
  }

  Widget myItem(MeListItem item) {
    return Container(
      height: 56.w,
      color: AppColors.primaryBackground,
      margin: EdgeInsets.only(bottom: 1.w),
      padding: EdgeInsets.only(top: 0.w, left: 15.w, right: 15.w),
      child: InkWell(
        onTap: ()
        {
          if(item.route=="/logout")
          {
            controller.onLogout();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 56.w,
                  child: Image(
                    image: AssetImage(
                      item.icon ?? "",
                    ),
                    width: 40.w,
                    height: 40.w,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w),
                  child: Text(
                    item.name ?? "",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.thirdElement,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image(
                    image: const AssetImage(
                      "assets/icons/ang.png",
                    ),
                    width: 15.w,
                    height: 15.w,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
