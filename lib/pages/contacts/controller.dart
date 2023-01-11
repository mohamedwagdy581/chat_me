import 'dart:convert';

import 'package:chat_me/common/entities/entities.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/store/user.dart';
import 'index.dart';

class ContactController extends GetxController {
  final state = ContactState();

  ContactController();

  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  goChat(UserData toUserData) async {
    var fromMessage = await db
        .collection('message')
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_uid', isEqualTo: token)
        .where('to_uid', isEqualTo: toUserData.id)
        .get();

    var toMessage = await db
        .collection('message')
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_uid', isEqualTo: toUserData.id)
        .where('to_uid', isEqualTo: token)
        .get();

    if(fromMessage.docs.isEmpty && toMessage.docs.isEmpty)
    {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity userData = UserLoginResponseEntity.fromJson(jsonDecode(profile));

      var msgData = Msg(
        from_uid: userData.accessToken,
        to_uid: toUserData.id,
        from_name: userData.displayName,
        to_name: toUserData.name,
        from_avatar: userData.photoUrl,
        to_avatar: toUserData.photourl,
        last_msg: '',
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      
      db.collection('message').withConverter(fromFirestore: Msg.fromFirestore, toFirestore: (Msg msg, options)=> msg.toFirestore()).add(msgData).then((value)
      {
        Get.toNamed('/chat', parameters:
        {
          'doc_id' : value.id,
          'to_uid' : toUserData.id??'',
          'to_name' : toUserData.name??'',
          'to_avatar' : toUserData.photourl??'',
        });
      });
      
    }else
    {
      if(fromMessage.docs.isNotEmpty)
      {
        Get.toNamed('/chat', parameters:
        {
          'doc_id' : fromMessage.docs.first.id,
          'to_uid' : toUserData.id??'',
          'to_name' : toUserData.name??'',
          'to_avatar' : toUserData.photourl??'',
        });
      }
      if(toMessage.docs.isNotEmpty)
      {
        Get.toNamed('/chat', parameters:
        {
          'doc_id' : toMessage.docs.first.id,
          'to_uid' : toUserData.id??'',
          'to_name' : toUserData.name??'',
          'to_avatar' : toUserData.photourl??'',
        });
      }
    }

  }

  asyncLoadAllData() async {
    var userBase = await db
        .collection('users')
        .where('id', isNotEqualTo: token)
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .get();

    for (var doc in userBase.docs) {
      state.contactList.add(doc.data());
    }
  }
}
