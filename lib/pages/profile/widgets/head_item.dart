import 'package:chat_me/common/entities/entities.dart';
import 'package:chat_me/common/values/colors.dart';
import 'package:chat_me/common/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget headItem(UserLoginResponseEntity item)
{
  return Container(
    padding: EdgeInsets.only(top: 30.w, left: 15.w, right: 15.w, bottom: 15.w),
    margin: EdgeInsets.only(bottom: 30.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
      boxShadow: const [
        BoxShadow(
          color: AppColors.tabCellSeparator,
          offset: Offset(0.0, 5.0),
          blurRadius: 15.0,
          spreadRadius: 1.0,
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){},
              child: SizedBox(
                height: 54.w,
                width: 54.w,
                child: netImageCached(
                  item.photoUrl??"",
                  height: 54.w,
                  width: 54.w,
                ),
              ),
            ),
            SizedBox(
              width: 250.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 190.w,
                    height: 54.w,
                    padding: EdgeInsets.only(top: 5.w, left: 15.w, right: 0.w, bottom: 0.w),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.displayName??"",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Avenir",
                            color: AppColors.thirdElement,
                          ),
                        ),
                        Text(
                          "ID: ${item.accessToken??""}",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Avenir",
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

      ],
    ),
  );
}