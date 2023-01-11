import 'package:chat_me/common/entities/entities.dart';
import 'package:chat_me/common/utils/http.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:location/location.dart';

import '../../common/store/user.dart';
import 'state.dart';

class MessageController extends GetxController {
  MessageController();

  final MessageState state = MessageState();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;

  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  @override
  void onReady() {
    super.onReady();
    getUserLocation();
    getFcmToken();
  }

  void onRefresh()
  {
    asyncLoadAllData().then((_)
    {
      refreshController.refreshCompleted(resetFooterState: true,);
    }).catchError((_)
    {
      refreshController.refreshFailed();
    });
  }

  void onLoading()
  {
    asyncLoadAllData().then((_)
    {
      refreshController.loadComplete();
    }).catchError((_)
    {
      refreshController.refreshFailed();
    });
  }

  asyncLoadAllData() async {
    var fromMessage = await db.collection('message').withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        ).where('from_uid', isEqualTo: token).get();

    var toMessage = await db.collection('message').withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg, options) => msg.toFirestore(),
    ).where('to_uid', isEqualTo: token).get();
    state.msgList.clear();
    if(fromMessage.docs.isNotEmpty)
    {
      state.msgList.assignAll(fromMessage.docs);
    }

    if(toMessage.docs.isNotEmpty)
    {
      state.msgList.assignAll(toMessage.docs);
    }

  }
  
  getUserLocation() async
  {
    try
    {
      final location = await Location().getLocation();
      String address = "${location.latitude}, ${location.longitude}";
      String url = "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyDc6PZtCHD9Px1tW29gJS9mQn2oRxOyXJI";
      var response = await HttpUtil().get(url);
      MyLocation location_res = MyLocation.fromJson(response);
      if(location_res.status=="OK")
      {
        String? myAddress = location_res.results?.first.formattedAddress;
        if(myAddress!=null)
        {
          var user_location = await db.collection('users').where('id', isEqualTo: token).get();
          if(user_location.docs.isNotEmpty)
          {
            var doc_id = user_location.docs.first.id;
            await db.collection('users').doc(doc_id).update({'location' : myAddress});
          }
        }
      }
    }catch(e)
    {
      print('Getting Error: $e');
    }
  }

  getFcmToken() async
  {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if(fcmToken != null)
    {
      var user = await db.collection('users').where('id', isEqualTo: token).get();
      if(user.docs.isNotEmpty)
      {
        var doc_id = user.docs.first.id;
        await db.collection('users').doc(doc_id).update(
            {
              "fcmtoken" : fcmToken,
            });
      }
    }
  }
}
