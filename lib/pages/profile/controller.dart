import 'dart:convert';

import 'package:chat_me/common/entities/entities.dart';
import 'package:chat_me/common/routes/names.dart';
import 'package:chat_me/common/store/store.dart';
import 'package:chat_me/pages/profile/state.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController
{
  final ProfileState state = ProfileState();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapies.com/auth/contacts.readonly'
    ],
  );

  asyncLoadAllData() async
  {
    String profile = await UserStore.to.getProfile();
    if(profile.isNotEmpty)
    {
      UserLoginResponseEntity userData = UserLoginResponseEntity.fromJson(jsonDecode(profile));
      state.head_detail.value = userData;
    }
  }

  Future<void> onLogout() async
  {
    UserStore.to.onLogout();
    await _googleSignIn.signOut();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }

  @override
  void onInit() {
    super.onInit();
    asyncLoadAllData();
    List myList = [
      {"name":"Account", "icon":"assets/icons/1.png", "route":"/account"},
      {"name":"Chat", "icon":"assets/icons/2.png", "route":"/chat"},
      {"name":"Notification", "icon":"assets/icons/3.png", "route":"/notification"},
      {"name":"Privacy", "icon":"assets/icons/4.png", "route":"/privacy"},
      {"name":"Help", "icon":"assets/icons/5.png", "route":"/help"},
      {"name":"About", "icon":"assets/icons/6.png", "route":"/about"},
      {"name":"Logout", "icon":"assets/icons/7.png", "route":"/logout"},
    ];

    for(int i=0; i < myList.length; i++)
    {
      MeListItem results = MeListItem();
      results.route = myList[i]['route'];
      results.name = myList[i]['name'];
      results.icon = myList[i]['icon'];
      state.meListItem.add(results);
    }
  }
}