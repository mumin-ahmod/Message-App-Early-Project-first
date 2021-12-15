
import 'package:get/get.dart';
import 'package:message_basic/data/message_dao.dart';
import 'package:message_basic/data/user_dao.dart';

class InstanceBinding implements Bindings{
  @override
  void dependencies() {

    Get.put<UserDao>(UserDao());

    Get.put<MessageDao>(MessageDao());

  }



}