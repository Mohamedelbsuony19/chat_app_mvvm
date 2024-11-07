import 'package:chat_c5/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/message.dart';
import '../../../models/my_user.dart';

class DatabaseUtils {
  static CollectionReference<MyUser> getUserColliction() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());
  }

  static CollectionReference<Room> getRoomColliction() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
            toFirestore: (room, _) => room.toJson());
  }

  static Future<List<Room>> getRoomsFromFirestore() async {
    var getroom = await getRoomColliction().get();
    return getroom.docs.map((e) => e.data()).toList();
  }

  static CollectionReference<Message> getMessageColliction(String roomId) {
    return getRoomColliction()
        .doc(roomId)
        .collection(Message.collictionName)
        .withConverter(
            fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
            toFirestore: (messagee, _) => messagee.toFireStore());
  }

  static Future<void> createDatabase(MyUser user) async {
    return await getUserColliction().doc(user.id).set(user);
  }

  static Future<MyUser?> readuser(String userId) async {
    var userDocSnapshot = await getUserColliction().doc(userId).get();
    return userDocSnapshot.data();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>? streamroom() {
    var data = FirebaseFirestore.instance.collection('Room').snapshots();
    return data;
  }

  static Future<void> createRoom(String title, des, catId) {
    var roomCollictions = getRoomColliction();
    var docRef = roomCollictions.doc();
    Room room = Room(id: docRef.id, title: title, desc: des, catid: catId);
    return docRef.set(room);
  }

  static Future<List<Room>> getRoomsFromFireStore() async {
    var qsnapshot = await getRoomColliction().get();
    return qsnapshot.docs.map((e) => e.data()).toList();
  }

  static Stream<QuerySnapshot<Room>> listenStreamForRoom() {
    return getRoomColliction().snapshots();
  }

  static Stream<QuerySnapshot<Message>> getMessageSream(String roomId) {
    return getMessageColliction(roomId).orderBy('dateTime').snapshots();
  }

  static Future<void> insertMessageToRoom(Message message) async {
    var roomMessages = getMessageColliction(message.roomId);
    var docRef = roomMessages.doc();
    message.id = docRef.id;
    return await docRef.set(message);
  }
}
