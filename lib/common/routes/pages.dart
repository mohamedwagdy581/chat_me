
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../pages/application/index.dart';
import '../../pages/contacts/index.dart';
import '../../pages/message/chat/index.dart';
import '../../pages/message/photoview/index.dart';
import '../../pages/profile/index.dart';
import '../../pages/signin/index.dart';
import '../../pages/welcome/index.dart';
import '../middlewares/router_auth.dart';
import '../middlewares/router_welcome.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const APPlication = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),

    // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares:  [
        RouteAuthMiddleware(priority: 1),
      ],
    ),

    // Contacts
    GetPage(
      name: AppRoutes.Contact,
      page: () => const ContactPage(),
      binding: ContactBinding(),
    ),
    /*
    //消息
    GetPage(name: AppRoutes.Message, page: () => MessagePage(), binding: MessageBinding()),
     */
    // Profile
    GetPage(
        name: AppRoutes.Me,
        page: () => const ProfilePage(),
        binding: ProfileBinding(),
    ),


    // Chat
    GetPage(
        name: AppRoutes.Chat,
        page: () => const ChatPage(),
        binding: ChatBinding(),
    ),

    // Photo Image View
    GetPage(
        name: AppRoutes.Photoimgview,
        page: () => const PhotoImageViewPage(),
        binding: PhotoImageViewBinding(),
    ),


  ];





}
