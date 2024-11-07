import 'package:chat_c5/core/helper/base_mvvm.dart';
import 'package:chat_c5/models/my_user.dart';

abstract class LoginNafigator implements BaseNavigator{
  void goToHome(MyUser user);
}