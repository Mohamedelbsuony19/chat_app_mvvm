import 'package:chat_c5/core/helper/base_mvvm.dart';
import 'package:chat_c5/models/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/helper/database/database_utils.dart';
import '../../../models/message.dart';
import '../../../models/room.dart';
import 'chat_provider.dart';

class ChatViewModel extends BaseViewModel<NavigatorChat> {
  late Room room;
  late MyUser currentUser;
  late Stream<QuerySnapshot<Message>> streamMessage;
  void sendMessage(String contentMessage) async {
    if (contentMessage.trim().isEmpty) {
      return;
    }
    var message = Message(
        roomId: room.id,
        content: contentMessage,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        senderName: currentUser.userName,
        senderId: currentUser.id);
    try {
      await DatabaseUtils.insertMessageToRoom(message);
      navigator?.clearMessagetext();
      navigator?.scroll();
    } catch (ex) {
      navigator?.showMessage(ex.toString());
    }
  }

  void listenStremMessages() {
    streamMessage = DatabaseUtils.getMessageSream(room.id);
  }
}
