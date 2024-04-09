import 'package:booking_zoo/featutes/animal/controller/create_animal_controller.dart';
import 'package:booking_zoo/featutes/room_animal/controller/create_room_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Config/Themes/set_theme_app.dart';
import '../../../Utils/UI/cs_buttom_sheet.dart';
import '../../../shared_components/custom_dropdown.dart';
import '../../../shared_components/form_email.dart';

class CustomRoundController {
  addTimeShow(
      {required BuildContext context,
      required TextEditingController nameAnimal,
      required TextEditingController nameRoom,
      required TextEditingController time,
      required List<dynamic> addData,
      required void Function() onTap}) {
    CusButTomSheet().sheet(
      ok: () {
        onTap.call();
        navigatorState.currentState?.pop();
      },
      // phatImage: true,
      textEditingController1: nameAnimal,
      textEditingController2: nameRoom,
      textEditingController3: time,
      context: context,
      title: "เพิ่มรอบเวลา",
      dropdownFiled_1: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final data = ref.watch(roomProvider);
            return CustomDropDown(
                isExpanded: true,
                hint: 'Room 1',
                hintIcon: const Icon(
                  Icons.room_preferences_rounded,
                  size: 25,
                  color: Colors.green,
                ),
                onChanged: (value) {
                  nameRoom.text = value!;
                },
                item: data.maybeWhen(
                  orElse: () => [],
                  data: (data) {
                    List<String> nameRoom = [];
                    data.forEach((element) {
                      nameRoom.add(element.nameRoom);
                    });
                    return nameRoom;
                  },
                ),
                direction: DropdownDirection.left);
          }),
        ],
      ),
      dropdownFiled_2: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final data = ref.watch(animalProvider);
            return CustomDropDown(
              isExpanded: true,
              hint: 'Tiger',
              hintIcon: const Icon(
                Icons.catching_pokemon,
                size: 25,
                color: Colors.green,
              ),
              onChanged: (value) {
                nameAnimal.text = value!;
              },
              item: data.maybeWhen(
                orElse: () => [],
                data: (data) {
                  List<String> nameAnimal = [];
                  data.forEach((element) {
                    nameAnimal.add(element.nameAnimal);
                  });
                  return nameAnimal;
                },
              ),
              direction: DropdownDirection.left,
            );
          }),
        ],
      ),
      textFiled_3: FormEmail(
          icon: const Icon(Icons.access_time_outlined),
          controller: time,
          textErr: "กรอกเวลา",
          hintText: "10.00 Am"),
    );
  }

  editTimeShow(
      {required BuildContext context,
      required TextEditingController editNameAnimal,
      required TextEditingController editNameRoom,
      required TextEditingController editTime,
      required int lIndex,
      required List<dynamic> addData,
      required void Function() onTap}) {
    CusButTomSheet().sheet(
      ok: () {
        onTap.call();
      },
      textEditingController1: editNameAnimal,
      textEditingController2: editNameRoom,
      textEditingController3: editTime,
      context: context,
      title: "แก้ไขรอบเวลา",
      dropdownFiled_1: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final data = ref.watch(roomProvider);
            return CustomDropDown(
              isExpanded: true,
              hint: editNameRoom.text,
              hintIcon: const Icon(
                Icons.room_preferences_rounded,
                size: 25,
                color: Colors.green,
              ),
              onChanged: (value) {
                editNameRoom.text = value!;
              },
              item: data.maybeWhen(
                orElse: () => [],
                data: (data) {
                  List<String> nameRoom = [];
                  data.forEach((element) {
                    nameRoom.add(element.nameRoom);
                  });
                  return nameRoom;
                },
              ),
              direction: DropdownDirection.left,
            );
          }),
        ],
      ),
      dropdownFiled_2: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final data = ref.watch(animalProvider);
            return CustomDropDown(
              isExpanded: true,
              hint: editNameAnimal.text,
              hintIcon: const Icon(
                Icons.catching_pokemon,
                size: 25,
                color: Colors.green,
              ),
              onChanged: (value) {
                editNameAnimal.text = value!;
              },
              item: data.maybeWhen(
                orElse: () => [],
                data: (data) {
                  List<String> nameAnimal = [];
                  data.forEach((element) {
                    nameAnimal.add(element.nameAnimal);
                  });
                  return nameAnimal;
                },
              ),
              direction: DropdownDirection.left,
            );
          }),
        ],
      ),
      textFiled_3: FormEmail(
          icon: const Icon(Icons.access_time_outlined),
          controller: editTime,
          textErr: "กรอกเวลา",
          hintText: "10.00 Am"),
    );
  }
}
