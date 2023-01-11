// ignore_for_file: depend_on_referenced_packages

import 'package:chat_me/common/values/colors.dart';
import 'package:chat_me/pages/message/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              const ChatList(),
              Positioned(
                bottom: 0.h,
                height: 50.h,
                child: Container(
                  height: 50.h,
                  width: 360.w,
                  color: AppColors.primaryBackground,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 217.w,
                        height: 50.h,
                        child: TextField(
                          controller: controller.textController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          autofocus: false,
                          focusNode: controller.contentNode,
                          decoration: const InputDecoration(
                            hintText: 'Send Message...',
                          ),
                        ),
                      ),
                      Container(
                        height: 30.h,
                        width: 30.w,
                        margin: EdgeInsets.only(left: 5.w),
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: const Icon(
                            Icons.photo_outlined,
                          ),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 65.w,
                        margin: EdgeInsets.only(left: 10.w, top: 5.h),
                        child: ElevatedButton(
                          onPressed: () {
                            controller.sendMessage();
                          },
                          child: const Text(
                            'Send',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 176, 106, 231),
              Color.fromARGB(255, 166, 112, 231),
              Color.fromARGB(255, 131, 123, 231),
              Color.fromARGB(255, 104, 132, 231),
            ],
            transform: GradientRotation(90.0),
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 44.w,
                  height: 44.w,
                  child: CachedNetworkImage(
                    imageUrl: controller.state.to_avatar.value,
                    imageBuilder: (context, imageProvider) => Container(
                      margin: null,
                      height: 44.w,
                      width: 44.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(44.w)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Image(
                      image: AssetImage(
                        'assets/images/feature-1.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Container(
              padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 180.w,
                    height: 44.w,
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.state.to_name.value,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBackground,
                              fontFamily: 'Avenir',
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.state.to_location.value,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: AppColors.primaryBackground,
                                fontFamily: 'Avenir',
                              ),
                            ),
                          ),
                        ],
                      ),
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

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                onTap: () {
                  controller.imgFromGallery();
                  Get.back();
                },
                leading: const Icon(
                  Icons.photo_library,
                ),
                title: const Text('Gallery'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.camera_alt,
                ),
                title: const Text('Camera'),
              ),
            ],
          ),
        );
      },
    );
  }
}
