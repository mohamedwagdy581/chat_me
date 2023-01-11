import 'package:chat_me/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../common/entities/user.dart';
import '../controller.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: controller.state.contactList.length,
                    (context, index) {
                  var item = controller.state.contactList[index];
                  return buildListItem(item);
                }),
          ),
        ),
      ],
    ));
  }

  Widget buildListItem(UserData item) {
    return Container(
      padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w),
      child: InkWell(
        onTap: ()
        {
          if(item.id!=null)
          {
            controller.goChat(item);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 15.w),
              child: SizedBox(
                width: 54.w,
                height: 54.w,
                child: CachedNetworkImage(
                  imageUrl: '${item.photourl}',
                ),
              ),
            ),
            Container(
              width: 250.w,
              padding: EdgeInsets.only(top: 15.w, left: 0.w, right: 0.w, bottom: 0.w),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFe5efe5), width: 1),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 200.w,
                    height: 42.w,
                    child: Text(
                      item.name??'',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Avenir',
                        color: AppColors.thirdElement,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
