import 'package:chat_c5/core/helper/base_mvvm.dart';
import 'package:chat_c5/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../home/home_screen.dart';
import '../register/register_screen.dart';
import 'login_navigator.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNafigator {
  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  String email = '';

  String password = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (buildContext) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('LogIn'),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1),
                          child: Image.asset('assets/images/group.png')),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            onChanged: (text) {
                              email = text;
                            },
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please enter Email';
                              }

                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(text);
                              if (!emailValid) {
                                return 'email format not valid';
                              }
                              return null;
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          onChanged: (text) {
                            password = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter password';
                            }
                            if (text.trim().length < 6) {
                              return 'password should be at least 6 chars';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          child: const Text('Log In')),
                      const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Donn\'t have an account'),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RegisterScreen.routeName);
                              },
                              child: const Text(
                                'register',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      viewModel.logIn(email, password);
    }
  }

  @override
  void goToHome(MyUser user) {
    var userprovider = Provider.of<UserProvider>(context, listen: false);
    userprovider.user = user;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
