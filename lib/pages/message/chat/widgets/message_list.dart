import 'package:chat_me/common/utils/date.dart';
import 'package:chat_me/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../common/entities/msg.dart';
import '../../controller.dart';

class MessageList extends GetView<MessageController> {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onLoading: controller.onLoading,
          onRefresh: controller.onRefresh,
          header: const WaterDropHeader(),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var item = controller.state.msgList[index];
                      return messageListItem(item);
                    },
                    childCount: controller.state.msgList.length,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget messageListItem(QueryDocumentSnapshot<Msg> item) {
    // The Container of Message List Item
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w),
      child: InkWell(
        onTap: ()
        {
          var toUid = '';
          var toName = '';
          var toAvatar = '';
          if(item.data().from_uid == controller.token)
          {
            toUid = item.data().to_uid??'';
            toName = item.data().to_name??'';
            toAvatar = item.data().to_avatar??'';
          }else
          {
            toUid = item.data().from_uid??'';
            toName = item.data().from_name??'';
            toAvatar = item.data().from_avatar??'';
          }
          Get.toNamed('/chat', parameters:
          {
            'doc_id' : item.id,
            'to_uid' : toUid,
            'to_name' : toName,
            'to_avatar' : toAvatar,
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // The Message Photo (Avatar)
            Padding(
              padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 15.w),
              child: SizedBox(
                width: 54.w,
                height: 54.w,
                child: CachedNetworkImage(
                  imageUrl: item.data().from_uid == controller.token
                      ? item.data().to_avatar!
                      : item.data().from_avatar!,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 54.w,
                    height: 54.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(54.w)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        )),
                  ),
                  errorWidget: (context, url, error) => const Image(
                    image: AssetImage(
                      'assets/images/feature-1.png',
                    ),
                  ),
                ),
              ),
            ),

            // The Row of Name and Last Message and Time
            Container(
              padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 5.w),
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xffe5e5e5))),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // Name and Last Message
                  SizedBox(
                    width: 180.w,
                    height: 48.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.data().from_uid == controller.token
                              ? item.data().to_name!
                              : item.data().from_name!,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Avenir',
                            color: AppColors.thirdElement,
                          ),
                        ),

                        // Last Message
                        Text(
                          item.data().last_msg??'',
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Avenir',
                            color: AppColors.thirdElement,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Time of Last Message
                  SizedBox(
                    width: 60.w,
                    height: 54.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          duTimeLineFormat((item.data().last_time as Timestamp).toDate()),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Avenir',
                            color: AppColors.thirdElementText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
