import 'package:chat_c5/core/helper/base_mvvm.dart';
import 'package:chat_c5/core/helper/database/database_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/room.dart';
import 'home_navigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];
  late Stream<QuerySnapshot<Room>> roomStream;

  void getRooms() async {
    rooms = await DatabaseUtils.getRoomsFromFireStore();
    notifyListeners();
  }

  void listenRoomUpdate() {
    roomStream = DatabaseUtils.listenStreamForRoom();
    notifyListeners();
  }
}
