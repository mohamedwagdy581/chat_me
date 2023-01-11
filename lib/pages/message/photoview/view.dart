// ignore_for_file: depend_on_referenced_packages

import 'package:chat_me/common/values/colors.dart';
import 'package:chat_me/pages/message/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'controller.dart';

class PhotoImageViewPage extends GetView<PhotoImageViewController> {
  const PhotoImageViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(
            controller.state.url.value,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar()
  {
    return AppBar(
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.secondaryElement,
            height: 2.0,
          ),
      ),
      title: const Text('Photo View',),
    );
  }
}
