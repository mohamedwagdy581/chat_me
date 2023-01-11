import 'package:chat_me/common/values/colors.dart';
import 'package:chat_me/common/widgets/app.dart';
import 'package:chat_me/pages/contacts/widgets/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controller.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const ContactList(),
    );
  }

  AppBar _buildAppBar()
  {
    return transparentAppBar(
      title: Text(
          'Contact',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryBackground,
        ),
      ),
    );
  }

}
