import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Utils/UI/custom_diarlog.dart';
import '../../../utils/services/local_storage.dart';
import '../../main/models/admin_model.dart';

class AnimalController extends AsyncNotifier<List<Animal>> {
  @override
  build() {
    return loadData();
  }

  Future<List<Animal>> loadData() async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');
    return cvData.animal;
  }

  void createAnimal({
    required String name,
    required String type,
    required String imagePath,
    required String timeShow,
    required String gene,
    required BuildContext context,
  }) async {
    final getData = await LocalStorage.instance.getDBAdmin();

    final cvData = adMinFromJson(str: getData ?? '');

    if (cvData.animal.isNotEmpty) {
      if (cvData.animal.every((element) => element.nameAnimal != name)) {
        List<Animal> newAnimal = [];
        for (var element in cvData.animal) {
          newAnimal.add(element);
        }

        newAnimal.add(Animal(
            type: type,
            imagePath: imagePath,
            gene: gene,
            timeShow: timeShow,
            nameAnimal: name));
        LocalStorage.instance.setDBAdmin(
            data: adMinToJson(AdminModel(
                useName: cvData.useName,
                room: cvData.room,
                round: cvData.round,
                animal: newAnimal)));
      } else {
        CustomDiarlog().diarlog(
          context: context,
          title: "ผิดพลาด",
          content1: "มี ''$name'' อยู่แล้ว",
          content2: null,
          content3: null,
        );
      }
    } else {
      final firstAnimal = Animal(
          type: type,
          imagePath: imagePath,
          gene: gene,
          timeShow: timeShow,
          nameAnimal: name);
      LocalStorage.instance.setDBAdmin(
          data: adMinToJson(AdminModel(
              useName: cvData.useName,
              room: cvData.room,
              round: cvData.round,
              animal: [firstAnimal])));
    }

    state = AsyncValue.data(await loadData());
  }

  void upDate({
    required String name,
    required String type,
    required String timeShow,
    required String gene,
    required int index,
    required BuildContext context,
  }) async {
    final getData = await LocalStorage.instance.getDBAdmin();
    final cvData = adMinFromJson(str: getData ?? '');
    final getAnimal = await loadData();

    if (getAnimal.every((element) => element.nameAnimal != name)) {
      getAnimal[index].nameAnimal = name;
      getAnimal[index].type = type;
      getAnimal[index].gene = gene;
      getAnimal[index].timeShow = timeShow;

      LocalStorage.instance.setDBAdmin(
          data: adMinToJson(AdminModel(
              useName: cvData.useName,
              room: cvData.room,
              round: cvData.round,
              animal: getAnimal)));
    } else {
      if (getAnimal[index].nameAnimal == name) {
        getAnimal[index].type = type;
        getAnimal[index].gene = gene;
        getAnimal[index].timeShow = timeShow;

        LocalStorage.instance.setDBAdmin(
            data: adMinToJson(AdminModel(
                useName: cvData.useName,
                room: cvData.room,
                round: cvData.round,
                animal: getAnimal)));
      } else {
        CustomDiarlog().diarlog(
          context: context,
          title: "ผิดพลาด",
          content1: "มี '$name'อยู่แล้ว",
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
    final getAnimal = await loadData();

    getAnimal.removeAt(index);
    LocalStorage.instance.setDBAdmin(
        data: adMinToJson(AdminModel(
            useName: cvData.useName,
            room: cvData.room,
            round: cvData.round,
            animal: getAnimal)));

    state = AsyncValue.data(await loadData());
  }
}

final animalProvider =
    AsyncNotifierProvider<AnimalController, List<Animal>>(AnimalController.new);
