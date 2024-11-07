import 'add_room_navigator.dart';
import '../../../core/helper/base_mvvm.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void createingRoom(
    String roomTitle,
    String roomDes,
    String catId,
  ) async {
    navigator?.showLoading(message: 'Creating Room ...');
    try {
      // var res = await DatabaseUtils.createRoom(roomTitle, roomDes, catId);
      navigator?.createdRoom();
    } catch (ex) {
      navigator?.showMessage(ex.toString());
    }
  }
}
