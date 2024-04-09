import 'package:booking_zoo/featutes/room_animal/controller/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Utils/UI/custom_diarlog.dart';
import '../../../utils/services/local_storage.dart';
import '../../main/models/admin_model.dart';

class RoomController extends AsyncNotifier<List<Room>> {
  @override
  build() {
    updateRadio = ref.watch(currentRadio);
    return loadData();
  }

  Future<List<Room>> loadData() async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');

    return cvData.room;
  }

  List<dynamic> updateRadio = [];

  final List<String> _dataRadio = [];
  void addRadio(
      {required int index,
      required List<String> data,
      required bool create,
      int? indexRadio}) {
    if (create == true) {
      if (index >= 0 && index < data.length) {
        // Check if the item corresponding to the clicked index is already in p
        if (_dataRadio.contains(data[index])) {
          // If it is, remove it
          _dataRadio.remove(data[index]);
        } else {
          // If it's not, add it
          _dataRadio.add(data[index]);
        }
      }
    } else {
      if (index >= 0 && index < data.length) {
        //  Check if the item corresponding to the clicked index is already in p
        if (updateRadio.contains(data[index])) {
          // If it is, remove it
          updateRadio.remove(data[index]);
        } else {
          // If it's not, add it
          updateRadio.add(data[index]);
        }
      }
    }

    print("create >>>>$_dataRadio");
    print("update >>>>$updateRadio");
  }

  void createRoom({
    required String name,
    required String seat,
    required String price,
    required List<String> type,
    required BuildContext context,
  }) async {
    final getData = await LocalStorage.instance.getDBAdmin();

    final cvData = adMinFromJson(str: getData ?? '');

    if (cvData.room.isNotEmpty) {
      if (cvData.room.every((element) => element.nameRoom != name)) {
        List<Room> newRoom = [];
        for (var element in cvData.room) {
          newRoom.add(element);
        }
        List<Seat> seats = [];
        for (int i = 1; i <= int.parse(seat); i++) {
          String prefix =
              String.fromCharCode('A'.codeUnitAt(0) + ((i - 1) ~/ 4));
          String value = '$prefix $i';
          seats.add(Seat(value: value, sttus: false));
        }
        newRoom.add(
            Room(nameRoom: name, seat: seats, price: price, gane: _dataRadio));
        LocalStorage.instance.setDBAdmin(
            data: adMinToJson(AdminModel(
                useName: cvData.useName,
                room: newRoom,
                round: cvData.round,
                animal: cvData.animal)));
      } else {
        CustomDiarlog().diarlog(
          context: context,
          title: "ผิดพลาด",
          content1: "มีห้องนี้อยู่แล้ว",
          content2: null,
          content3: null,
        );
      }
    } else {
      List<Seat> seats = [];
      for (int i = 1; i <= int.parse(seat); i++) {
        String prefix = String.fromCharCode('A'.codeUnitAt(0) + ((i - 1) ~/ 4));
        String value = '$prefix $i';
        seats.add(Seat(value: value, sttus: false));
      }
      LocalStorage.instance.setDBAdmin(
          data: adMinToJson(AdminModel(
              useName: cvData.useName,
              room: [
                Room(
                    nameRoom: name, seat: seats, price: price, gane: _dataRadio)
              ],
              round: cvData.round,
              animal: cvData.animal)));
    }

    state = AsyncValue.data(await loadData());
  }

  void upDate({
    required String name,
    required String seat,
    required String price,
    required int index,
    required BuildContext context,
  }) async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');
    final getRoom = await loadData();

    if (getRoom.every((element) => element.nameRoom != name)) {
      List<Seat> seats = [];
      for (int i = 1; i <= int.parse(seat); i++) {
        String prefix = String.fromCharCode('A'.codeUnitAt(0) + ((i - 1) ~/ 4));
        String value = '$prefix $i';
        seats.add(Seat(value: value, sttus: false));
      }
      getRoom[index].nameRoom = name;
      getRoom[index].seat = seats;
      getRoom[index].price = price;
      getRoom[index].gane = updateRadio;

      LocalStorage.instance.setDBAdmin(
          data: adMinToJson(AdminModel(
              useName: cvData.useName,
              room: getRoom,
              round: cvData.round,
              animal: cvData.animal)));
    } else {
      if (getRoom[index].nameRoom == name) {
        List<Seat> seats = [];
        for (int i = 1; i <= int.parse(seat); i++) {
          String prefix =
              String.fromCharCode('A'.codeUnitAt(0) + ((i - 1) ~/ 4));
          String value = '$prefix $i';
          seats.add(Seat(value: value, sttus: false));
        }
        getRoom[index].seat = seats;
        getRoom[index].price = price;
        getRoom[index].gane = updateRadio;

        LocalStorage.instance.setDBAdmin(
            data: adMinToJson(AdminModel(
                useName: cvData.useName,
                room: getRoom,
                round: cvData.round,
                animal: cvData.animal)));
      } else {
        CustomDiarlog().diarlog(
          context: context,
          title: "ผิดพลาด",
          content1: "มีห้องนี้อยู่แล้ว",
          content2: null,
          content3: null,
        );
      }
    }

    state = AsyncValue.data(await loadData());
  }

  void delete({required int index, required BuildContext context}) async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');
    final getRoom = await loadData();

    getRoom.removeAt(index);
    LocalStorage.instance.setDBAdmin(
        data: adMinToJson(AdminModel(
            useName: cvData.useName,
            room: getRoom,
            round: cvData.round,
            animal: cvData.animal)));

    state = AsyncValue.data(await loadData());
  }
}

final roomProvider =
    AsyncNotifierProvider<RoomController, List<Room>>(RoomController.new);
