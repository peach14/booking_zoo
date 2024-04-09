import 'package:booking_zoo/featutes/room_animal/controller/create_room_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/asset/asset_phat.dart';
import '../../featutes/animal/controller/create_animal_controller.dart';
import '../../featutes/room_animal/component/radio_custom_admin.dart';
import '../../shared_components/custom_dropdown.dart';

final imagePathProvider = StateProvider.autoDispose<String>((ref) => '');
final imageForEditProvider = StateProvider<String>((ref) => '');
final getRadioProvider = StateProvider<List<String>>((ref) {
  final animal = ref.watch(animalProvider);
  final data = animal.value;
  List<String> gane = [];
  data?.forEach((element) {
    gane.add(element.gene);
  });

  return gane.toSet().toList();
});

class CusButTomSheet {
  sheet({
    required BuildContext context,
    required String title,
    Widget? textFiled_1,
    Widget? textFiled_2,
    Widget? textFiled_3,
    Widget? textFiled_4,
    Widget? dropdownFiled_1,
    Widget? dropdownFiled_2,
    Widget? dropdownFiled_3,
    required VoidCallback ok,
    VoidCallback? cancel,
    TextEditingController? textEditingController1,
    TextEditingController? textEditingController2,
    TextEditingController? textEditingController3,
    TextEditingController? textEditingController4,
    bool? enableImage,
    bool? createRadio,
    bool? updateRadio,
    int? indexRadio,
    void Function(String? value)? addImage,
    void Function(String? value)? editImage,
    void Function()? onTap,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                    MediaQuery.of(context).size.shortestSide * 0.04),
                topLeft: Radius.circular(
                    MediaQuery.of(context).size.shortestSide * 0.04),
              ),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 9.2,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "ยกเลิก",
                                style: TextStyle(
                                    color: Color.fromARGB(147, 0, 0, 0)),
                              ));
                        },
                      ),
                      Text(title),
                      TextButton(
                          onPressed: ok,
                          child: const Text(
                            "ตกลง",
                            style: TextStyle(
                              color: Color.fromARGB(255, 245, 7, 4),
                            ),
                          ))
                    ],
                  ),
                ),
                Divider(
                    height: MediaQuery.of(context).size.height * 0.02,
                    color: Colors.black54),
                Expanded(
                  child: SizedBox(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          if (enableImage == true)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Consumer(
                                  builder: (BuildContext context, WidgetRef ref,
                                      Widget? child) {
                                    return Card(
                                      elevation: 10,
                                      child: addImage == null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(ref.watch(
                                                          imageForEditProvider)),
                                                      fit: BoxFit.fill)),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                            )
                                          : ref.watch(imagePathProvider).isEmpty
                                              ? Container(
                                                  color: Colors.white,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              ref.read(
                                                                  imagePathProvider)),
                                                          fit: BoxFit.fill)),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                ),
                                    );
                                  },
                                ),
                                addImage == null
                                    ? CustomDropDown(
                                        item: ImagePhat.groupAnimal,
                                        onChanged: editImage,
                                        botTon: const Icon(
                                            size: 35,
                                            Icons.edit,
                                            color: Colors.blue),
                                        direction: DropdownDirection.right,
                                      )
                                    : CustomDropDown(
                                        item: ImagePhat.groupAnimal,
                                        onChanged: addImage,
                                        botTon: const Icon(
                                            size: 35,
                                            Icons.add_photo_alternate,
                                            color: Colors.blue),
                                        direction: DropdownDirection.right,
                                      ),
                              ],
                            ),
                          dropdownFiled_1 ?? const SizedBox.shrink(),
                          const SizedBox(
                            height: 15,
                          ),
                          dropdownFiled_2 ?? const SizedBox.shrink(),
                          textFiled_1 ?? Container(),
                          textFiled_4 ?? Container(),
                          dropdownFiled_3 ?? const SizedBox.shrink(),
                          textFiled_2 ?? Container(),
                          textFiled_3 ?? Container(),
                          if (createRadio == true || updateRadio == true)
                            const Spacer(),
                          if (createRadio == true)
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                final data = ref.watch(getRadioProvider);
                                return Expanded(
                                    flex: 50,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "ประเภทสัตว์",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Expanded(
                                          child: GridView.builder(
                                            itemCount: data.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 5,
                                                    crossAxisCount: 2),
                                            itemBuilder: (context, index) {
                                              return CustomRadio(
                                                ontap: () {
                                                  ref
                                                      .read(
                                                          roomProvider.notifier)
                                                      .addRadio(
                                                          index: index,
                                                          data: data,
                                                          create: true);
                                                },
                                                laBle: data[index],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                            ),
                          if (updateRadio == true)
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                final data = ref.watch(getRadioProvider);
                                final room = ref.watch(roomProvider).value;
                                return Expanded(
                                    flex: 50,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "ประเภทสัตว์",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Expanded(
                                          child: GridView.builder(
                                            itemCount: data.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 5,
                                                    crossAxisCount: 2),
                                            itemBuilder: (context, index) {
                                              final currentRadio =
                                                  room?[indexRadio ?? 0]
                                                      .gane
                                                      .contains(data[index]);
                                              return CustomRadio(
                                                isSelected: currentRadio,
                                                ontap: () {
                                                  ref
                                                      .read(
                                                          roomProvider.notifier)
                                                      .addRadio(
                                                          index: index,
                                                          indexRadio:
                                                              indexRadio,
                                                          data: data,
                                                          create: false);
                                                },
                                                laBle: data[index],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
