import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/services/local_storage.dart';
import '../../main/models/admin_model.dart';

class RoundController extends AsyncNotifier<List<Round>> {
  @override
  build() {
    return loadData();
  }

  Future<List<Round>> loadData() async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');
    return cvData.round;
  }

  void addDeTile({
    required int index,
    required String roomRound,
    required String animalRound,
    required String time,
  }) async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');
    List<Round> deTile = cvData.round;
    deTile[index]
        .one
        .add(One(roomRound: roomRound, animalRound: animalRound, time: time));

    LocalStorage.instance.setDBAdmin(
        data: adMinToJson(AdminModel(
            useName: cvData.useName,
            room: cvData.room,
            round: deTile,
            animal: cvData.animal)));
    state = AsyncValue.data(await loadData());
  }

  void updateDeTile({
    required int mainIndex,
    required int deTileIndex,
    required String roomRound,
    required String animalRound,
    required String time,
  }) async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');
    List<Round> deTile = cvData.round;
    deTile[mainIndex].one[deTileIndex] =
        One(roomRound: roomRound, animalRound: animalRound, time: time);

    LocalStorage.instance.setDBAdmin(
        data: adMinToJson(AdminModel(
            useName: cvData.useName,
            room: cvData.room,
            round: deTile,
            animal: cvData.animal)));
    state = AsyncValue.data(await loadData());
  }

  void removeDeTile({
    required int mainIndex,
    required int deTileIndex,
  }) async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');
    List<Round> deTile = cvData.round;
    deTile[mainIndex].one.removeAt(deTileIndex);

    LocalStorage.instance.setDBAdmin(
        data: adMinToJson(AdminModel(
            useName: cvData.useName,
            room: cvData.room,
            round: deTile,
            animal: cvData.animal)));
    state = AsyncValue.data(await loadData());
  }

  void addRound() async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');

    List<Round> listRound = cvData.round;
    listRound.add(Round(one: []));
    LocalStorage.instance.setDBAdmin(
        data: adMinToJson(AdminModel(
            useName: cvData.useName,
            room: cvData.room,
            round: listRound,
            animal: cvData.animal)));
    state = AsyncValue.data(await loadData());
  }

  void deleteRound() async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');

    List<Round> listRound = cvData.round;
    listRound.removeLast();
    LocalStorage.instance.setDBAdmin(
        data: adMinToJson(AdminModel(
            useName: cvData.useName,
            room: cvData.room,
            round: listRound,
            animal: cvData.animal)));
    state = AsyncValue.data(await loadData());
  }
}

final roundProvider =
    AsyncNotifierProvider<RoundController, List<Round>>(RoundController.new);
