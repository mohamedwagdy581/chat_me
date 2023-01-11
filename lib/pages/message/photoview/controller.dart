
import 'package:chat_me/pages/message/photoview/index.dart';

import 'package:get/get.dart';


class PhotoImageViewController extends GetxController {
  final state = PhotoImageViewState();
  PhotoImageViewController();

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    if(data['url'] != null)
    {
      state.url.value = data['url']!;
    }
  }

}
