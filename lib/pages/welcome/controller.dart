import 'package:chat_me/common/routes/names.dart';
import 'package:chat_me/common/store/config.dart';
import 'package:chat_me/pages/welcome/state.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController
{
  final state = WelcomeState();
  WelcomeController();
  changePage(int index) async
  {
    state.index.value = index;
  }
  handleSignIn() async
  {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}