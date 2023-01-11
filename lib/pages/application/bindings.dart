import 'package:get/get.dart';

import '../contacts/controller.dart';
import '../message/controller.dart';
import '../profile/controller.dart';
import 'controller.dart';

class ApplicationBinding implements Bindings
{
  @override
  void dependencies()
  {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<MessageController>(() => MessageController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}