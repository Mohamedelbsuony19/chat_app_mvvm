import 'package:chat_c5/core/helper/base_mvvm.dart';
import 'package:chat_c5/presentation/screens/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/helper/database/database_utils.dart';
import '../../../models/my_user.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void register(String email, String password, String fristName,
      String lastName, String userName) async {
    try {
      navigator?.showLoading();
      var res = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = MyUser(
          id: res.user?.uid ?? '',
          fName: fristName,
          lName: lastName,
          userName: userName,
          email: email);
       await DatabaseUtils.createDatabase(user);
      navigator?.goHome(user);
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator?.hideDialog();
        navigator?.showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.hideDialog();
        navigator?.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      navigator?.showMessage(e.toString());
    }
  }
}
