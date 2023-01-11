import 'package:chat_me/common/entities/entities.dart';
import 'package:get/get.dart';

class ContactState
{
  final count = 0.obs;
  RxList<UserData> contactList = <UserData>[].obs;
}