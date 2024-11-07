import 'package:chat_c5/core/helper/base_mvvm.dart';
import 'package:chat_c5/presentation/provider/user_provider.dart';
import 'package:chat_c5/presentation/widgets/custom_text_form_feild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/message.dart';
import '../../../models/room.dart';
import '../../provider/theme_provider.dart';
import '../../widgets/message_widget.dart';
import 'chat_provider.dart';
import 'chat_viewmodel.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chatscreen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen, ChatViewModel>
    implements NavigatorChat {
  TextEditingController textController = TextEditingController();
  String messageContent = '';
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    Room room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room = room;
    var userProvider = Provider.of<UserProvider>(context);
    viewModel.currentUser = userProvider.user!;
    viewModel.listenStremMessages();
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Stack(children: [
        Container(
          color: themeProvider.isLight ? Colors.white : Colors.black,
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
            title: Text(room.title),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  icon: Icon(
                    themeProvider.isLight
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode,
                    size: 35,
                  ),
                  onPressed: () {
                    themeProvider.changeTheme();
                  },
                ),
              )
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
            decoration: BoxDecoration(
                color: const Color(0xFFbfdae0),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot<Message>>(
                  stream: viewModel.streamMessage,
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    var messages =
                        snapshot.data?.docs.map((e) => e.data()).toList();
                    return Expanded(
                      child: ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return MessageWidget(messages!.elementAt(index));
                        },
                        itemCount: messages?.length ?? 0,
                      ),
                    );
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      hint: 'Your Maessgae Here',
                      onChange: (d) {
                        messageContent = d;
                      },
                      suuf: const Icon(Icons.send),
                      ontabSuffixIcon: () {
                        viewModel.sendMessage(messageContent);
                      },
                      textEditingController: textController,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  @override
  ChatViewModel initViewModel() => ChatViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  void clearMessagetext() {
    textController.clear();
  }

  @override
  void scroll() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }
}
