import 'package:booking_zoo/featutes/animal/controller/show_animal_controller.dart';
import 'package:booking_zoo/featutes/main/models/admin_model.dart';
import 'package:booking_zoo/featutes/room_animal/controller/show_room_controller.dart';
import 'package:booking_zoo/featutes/round_booking/controller/create_round_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/services/local_storage.dart';

class ShowRoundController extends Notifier<List<Round>> {
  @override
  build() {
    return loadData() ?? [];
  }

  List<Round>? loadData() {
    final dataRoom = ref.watch(roundProvider);
    return dataRoom.value;
  }

  void selectRoom({
    required String nameRoom,
    required String nameAnimal,
  }) {
    final getAnimal = ref.watch(shoAnimalProvider);
    final getRoom = ref.watch(showRoomProvider);

    ref.read(onlyAnimal.notifier).update((state) => state =
        getAnimal.firstWhere((element) => element.nameAnimal == nameAnimal));
    ref.read(onlyRoom.notifier).update((state) =>
        state = getRoom.firstWhere((element) => element.nameRoom == nameRoom));
  }

  void save({required String nameRoom, required List<Seat> seat}) async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');
    final getRoom = ref.watch(showRoomProvider);

    for (var item in getRoom) {
      if (item.nameRoom == nameRoom) {
        item.seat = seat;
        break; // Stop looping once the element is found and updated
      }
    }
    LocalStorage.instance.setDBAdmin(
        data: adMinToJson(AdminModel(
            useName: cvData.useName,
            room: getRoom,
            round: cvData.round,
            animal: cvData.animal)));
  }
}

final onlyAnimal = StateProvider<Animal>((ref) =>
    Animal(type: '', imagePath: '', gene: '', timeShow: '', nameAnimal: ''));
final onlyRoom = StateProvider<Room>(
    (ref) => Room(nameRoom: '', seat: [], price: '', gane: []));
final showRoundProvider =
    NotifierProvider<ShowRoundController, List<Round>>(ShowRoundController.new);
