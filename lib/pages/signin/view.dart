// ignore_for_file: depend_on_referenced_packages

import 'package:chat_me/common/values/shadows.dart';
import 'package:chat_me/common/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import 'controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _buildLogo(),
            const Spacer(),
            _buildThirdPartyLogin(),
          ],
        ),
      ),
    );
  }

  // Sign In Screen Logo
  Widget _buildLogo() {
    return Container(
      width: 110.w,
      margin: EdgeInsets.only(top: 84.h),
      child: Column(
        children: [
          Container(
            width: 76.w,
            height: 76.w,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 76.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      boxShadow: const [
                        Shadows.primaryShadow,
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(15.w)),
                    ),
                  ),
                ),
                Positioned(
                  child: Image.asset(
                    'assets/images/ic_launcher.png',
                    width: 76.w,
                    height: 76.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
            child: Text(
                "Let's Chat",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.thirdElement,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThirdPartyLogin()
  {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(bottom: 280.h),
      child: Column(
        children: [
          Text(
            'Sign in with social networks',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryText,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0.h, left: 50.w, right: 50.w),
            child: btnFlatButtonWidget(
              onPressed: ()
              {
                controller.handleSignIn();
              },
              width: 200.w,
              height: 55.h,
              title: 'Google Login',
            ),
          ),
        ],
      ),
    );
  }
}
