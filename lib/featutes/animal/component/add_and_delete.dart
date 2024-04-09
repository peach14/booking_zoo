import 'package:booking_zoo/constants/constanst.dart';
import 'package:booking_zoo/featutes/animal/controller/create_animal_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared_components/custom_dropdown.dart';
import '../../../shared_components/form_email.dart';
import '../../../utils/ui/cs_buttom_sheet.dart';
import '../../main/models/admin_model.dart';

class AddAndDelete extends ConsumerStatefulWidget {
  const AddAndDelete({
    super.key,
  });

  @override
  ConsumerState<AddAndDelete> createState() => _AddAndDeleteState();
}

class _AddAndDeleteState extends ConsumerState<AddAndDelete> {
  TextEditingController nameAnimal = TextEditingController();
  TextEditingController species = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController showDuration = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final getData = ref.watch(animalProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: const Color.fromARGB(255, 1, 19, 44)),
                    onPressed: () {
                      add();
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.add),
                        Text("เพิ่มสัตว์"),
                      ],
                    )),
              ),
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
        const Spacer(),
        getData.when(
          data: (data) {
            if (data.isNotEmpty) {
              return Expanded(
                flex: 25,
                child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      mainAxisExtent: 300,
                      crossAxisSpacing: 20,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    constraints:
                                        const BoxConstraints(maxHeight: 300),
                                    child: Material(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      elevation: 10,
                                      child: InkWell(
                                          onTap: () {
                                            ref
                                                .read(imageForEditProvider
                                                    .notifier)
                                                .update((state) => state =
                                                    data[index].imagePath);
                                            edit(index, data);
                                          },
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 60),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.0),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            data[index]
                                                                .imagePath),
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    const Spacer(),
                                                    Text(
                                                      data[index].nameAnimal,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const Spacer(),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "ชนิด : ${data[index].type}",
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .shortestSide *
                                                                    0.035),
                                                          ),
                                                          Text(
                                                            "สายพันธุ์ : ${data[index].gene}",
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .shortestSide *
                                                                    0.035),
                                                          ),
                                                          Text(
                                                            "เวบาโชว์ : ${data[index].timeShow}",
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .shortestSide *
                                                                    0.035),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: -0,
                          right: -10,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(5, 25)),
                            onPressed: () {
                              delete(index, data);
                            },
                            child: const Text(
                              "ลบ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            } else {
              return const Expanded(
                  flex: 25,
                  child: Text(
                    textAlign: TextAlign.center,
                    "NO DATA ANIMAL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30),
                  ));
            }
          },
          error: (error, stackTrace) =>
              Expanded(flex: 25, child: Text("$error")),
          loading: () => const Expanded(flex: 25, child: Text("loading")),
        )
      ],
    );
  }

  void edit(int index, List<Animal> data) {
    TextEditingController nameAnimal =
        TextEditingController(text: data[index].nameAnimal);
    TextEditingController species =
        TextEditingController(text: data[index].gene);
    TextEditingController type = TextEditingController(text: data[index].type);
    TextEditingController showDuration =
        TextEditingController(text: data[index].timeShow);
    CusButTomSheet().sheet(
        ok: () {
          ref.read(animalProvider.notifier).upDate(
              name: nameAnimal.text,
              type: type.text,
              timeShow: showDuration.text,
              gene: species.text,
              index: index,
              context: context);
          Navigator.pop(context);
        },
        enableImage: true,
        editImage: (value) {
          ref
              .read(imageForEditProvider.notifier)
              .update((state) => state = value!);
        },
        textEditingController1: nameAnimal,
        textEditingController2: type,
        textEditingController4: species,
        textEditingController3: showDuration,
        context: context,
        title: "แก้ไขสัตว์",
        textFiled_1: FormEmail(
            icon: const Icon(Icons.adb),
            controller: nameAnimal,
            textErr: "กรอกชื่อสัตว์",
            hintText: "Tiger"),
        textFiled_2: FormEmail(
            icon: const Icon(Icons.type_specimen_outlined),
            controller: type,
            textErr: "กรอกชื่อห้อง",
            hintText: "Room 1"),
        textFiled_3: FormEmail(
            icon: const Icon(Icons.access_time_outlined),
            controller: showDuration,
            textErr: "กรอกเวลา",
            hintText: "10.00 Am"),
        // textFiled_4: FormEmail(
        //     icon: const Icon(Icons.spoke_rounded),
        //     controller: species,
        //     textErr: "กรอกเวลา",
        //     hintText: "10.00 Am"),
        dropdownFiled_3: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 15,
            ),
            CustomDropDown(
              isExpanded: true,
              hint: species.text,
              hintIcon: const Icon(
                Icons.catching_pokemon,
                size: 25,
                color: Colors.green,
              ),
              onChanged: (value) {
                species.text = value!;
              },
              item: ConsTans.instance.groupGeneAnimal,
              direction: DropdownDirection.left,
            ),
          ],
        ));
  }

  void delete(int index, List<Animal> data) {
    ref.read(animalProvider.notifier).delete(index: index, context: context);
  }

  void add() {
    CusButTomSheet().sheet(
      ok: () {
        ref.read(animalProvider.notifier).createAnimal(
            name: nameAnimal.text,
            type: species.text,
            imagePath: ref.watch(imagePathProvider),
            timeShow: showDuration.text,
            gene: type.text,
            context: context);
        nameAnimal.clear();
        type.clear();
        species.clear();
        Navigator.pop(context);
      },
      enableImage: true,
      addImage: (value) {
        ref.read(imagePathProvider.notifier).update((state) => state = value!);
      },
      textEditingController1: nameAnimal,
      textEditingController2: type,
      textEditingController3: showDuration,
      textEditingController4: species,
      context: context,
      title: "เพิ่มสัตว์",
      textFiled_1: FormEmail(
          icon: const Icon(Icons.adb),
          controller: nameAnimal,
          textErr: "กรอกชื่อสัตว์",
          hintText: "Tiger"),
      textFiled_4: FormEmail(
          icon: const Icon(Icons.spoke_rounded),
          controller: species,
          textErr: "ระบุชนิด",
          hintText: "Species"),
      dropdownFiled_3: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 15,
          ),
          CustomDropDown(
            isExpanded: true,
            hint: 'Type',
            hintIcon: const Icon(
              Icons.catching_pokemon,
              size: 25,
              color: Colors.green,
            ),
            onChanged: (value) {
              type.text = value!;
            },
            item: ConsTans.instance.groupGeneAnimal,
            direction: DropdownDirection.left,
          ),
        ],
      ),
      textFiled_3: FormEmail(
          icon: const Icon(Icons.access_time_outlined),
          controller: showDuration,
          textErr: "กรอกเวลา",
          hintText: "20 minutes"),
    );
  }
}
