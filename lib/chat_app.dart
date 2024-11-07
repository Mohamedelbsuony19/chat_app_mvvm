import 'package:chat_c5/presentation/provider/user_provider.dart';
import 'package:chat_c5/presentation/screens/add_room/add_room_screen.dart';
import 'package:chat_c5/presentation/screens/chat/chat_screen.dart';
import 'package:chat_c5/presentation/screens/home/home_screen.dart';
import 'package:chat_c5/presentation/screens/log_in/log_in_screen.dart';
import 'package:chat_c5/presentation/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
      routes: {
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        AddRoomScreen.routeName: (_) => const AddRoomScreen(),
        ChatScreen.routeName: (_) => const ChatScreen(),
      },
      initialRoute: provider.firebaseUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      title: 'chat app',
    );
  }
}
