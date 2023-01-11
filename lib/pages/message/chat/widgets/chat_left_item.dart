import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../../../../common/entities/msgcontent.dart';
import '../../../../common/routes/names.dart';

Widget chatLeftItem(Msgcontent item) {
  return Container(
    padding: EdgeInsets.only(top: 10.w, bottom: 10.w, right: 15.w, left: 15.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 230.w,
            minHeight: 40.w,
          ),
          child: Container(
            padding: EdgeInsets.only(top: 10.w, right: 10.w, left: 10.w),
            margin: EdgeInsets.only(right: 10.w, top: 10.w),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 176, 106, 231),
                    Color.fromARGB(255, 166, 112, 231),
                    Color.fromARGB(255, 131, 123, 231),
                    Color.fromARGB(255, 104, 132, 231),
                  ],
                  transform: GradientRotation(90.0),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.w))),
            child: item.type == 'text'
                ? Text('${item.content}')
                : ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 90.w),
              child: GestureDetector(
                onTap: ()
                {
                  Get.toNamed(AppRoutes.Photoimgview, parameters: {"url" : item.content??""});
                },
                child: CachedNetworkImage(
                  imageUrl: '${item.content}',
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
