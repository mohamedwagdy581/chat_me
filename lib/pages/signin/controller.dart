import 'package:chat_me/common/entities/entities.dart';
import 'package:chat_me/common/store/store.dart';
import 'package:chat_me/common/widgets/toast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/routes/names.dart';
import 'index.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes:<String>[
    'openid'
  ],
);

class SignInController extends GetxController
{
  final state = SignInState();
  SignInController();
  final db = FirebaseFirestore.instance;

  Future<void> handleSignIn() async
  {
    try
    {
      var user = await _googleSignIn.signIn();
      if(user != null)
      {

        final _getAuthentication = await user.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _getAuthentication.idToken,
          accessToken: _getAuthentication.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(_credential);

        String displayName = user.displayName??user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl??'';
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;

        UserStore.to.saveProfile(userProfile);
        var userBase = await db.collection('users').withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        ).where('id', isEqualTo:id).get();

        if(userBase.docs.isEmpty)
        {
          final data = UserData(
            id: id,
            email: email,
            name: displayName,
            photourl: photoUrl,
            location: '',
            fcmtoken: '',
            addtime: Timestamp.now(),
          );
          await db.collection('users').withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userData, options) => userData.toFirestore(),
          ).add(data);
        }
        toastInfo(msg: 'Login Success');
        Get.offAndToNamed(AppRoutes.Application);
      }
    }catch(e)
    {
      toastInfo(msg: 'Login Error');
    }
  }

  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user)
    {
      if(user == null)
      {
        toastInfo(msg: 'User is currently Logged Out');
      }else
      {
        toastInfo(msg: 'User is currently Logged In');
      }
    });
  }
}