import 'package:chat_c5/core/helper/base_mvvm.dart';
import 'package:chat_c5/models/my_user.dart';
import 'package:chat_c5/presentation/screens/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../home/home_screen.dart';
import 'register_navigator.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterViewModel>
    implements RegisterNavigator {
  String firsName = '';

  String lastName = '';

  String userName = '';

  String email = '';

  String password = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
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
              title: const Text('Register'),
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
                      const Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'First Name'),
                        onChanged: (text) {
                          firsName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter first Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Last Name'),
                          onChanged: (text) {
                            lastName = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter last Name';
                            }
                            return null;
                          }),
                      TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'User Name'),
                          onChanged: (text) {
                            userName = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter user Name';
                            }
                            if (text.contains(' ')) {
                              return 'user name must not contains white spaces';
                            }
                            return null;
                          }),
                      TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
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
                      TextFormField(
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
                      ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          child: const Text('Register')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('have an acount'),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState!.validate() == true) {
      viewModel.register(email, password, firsName, lastName, userName);
    }
  }

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  @override
  void goHome(MyUser user) {
    var userprovider = Provider.of<UserProvider>(context, listen: false);
    userprovider.user = user;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
