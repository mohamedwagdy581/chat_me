import 'package:chat_me/common/values/colors.dart';
import 'package:chat_me/common/widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chat/widgets/message_list.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const MessageList(),
    );
  }

  AppBar _buildAppBar()
  {
    return transparentAppBar(
      title: Text(
          'Message',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryBackground,
        ),
      ),
    );
  }
}
