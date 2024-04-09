import 'package:booking_zoo/constants/asset/asset_phat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared_components/form_email.dart';
import '../../../utils/ui/cs_buttom_sheet.dart';
import '../controller/create_room_controller.dart';
import '../controller/providers.dart';

class ListRoom extends ConsumerStatefulWidget {
  const ListRoom({
    super.key,
  });

  @override
  ConsumerState<ListRoom> createState() => _ListRoomState();
}

class _ListRoomState extends ConsumerState<ListRoom> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(roomProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      child: data.when(
        data: (data) {
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, lIndex) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.01),
                  child: Stack(
                    children: [
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(ImagePhat.room)),
                                )),
                            Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.015),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons
                                                    .meeting_room_outlined),
                                                Text(data[lIndex].nameRoom),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.chair,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .shortestSide *
                                                      0.05,
                                                  color: const Color.fromARGB(
                                                      255, 245, 7, 4),
                                                ),
                                                SizedBox(
                                                  width: 180,
                                                  child: Text(
                                                    "${data[lIndex].seat.length} ที่นั่ง",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .shortestSide *
                                                            0.037),
                                                    // overflow:
                                                    // TextOverflow.ellipsis
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '฿',
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 245, 7, 4),
                                                      fontSize: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .shortestSide *
                                                          0.045),
                                                ),
                                                Text(
                                                    " ${data[lIndex].price} บาท",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .shortestSide *
                                                            0.037)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7))),
                                        minimumSize: Size(
                                            90,
                                            MediaQuery.of(context).size.height *
                                                0.1),
                                        backgroundColor: const Color.fromARGB(
                                            255, 248, 219, 21),
                                      ),
                                      onPressed: () {
                                        ref.read(currentRadio.notifier).update(
                                            (state) => data[lIndex].gane);

                                        TextEditingController monny =
                                            TextEditingController(
                                                text: data[lIndex].price);
                                        TextEditingController chair =
                                            TextEditingController(
                                                text: data[lIndex]
                                                    .seat
                                                    .length
                                                    .toString());
                                        TextEditingController name =
                                            TextEditingController(
                                                text: data[lIndex].nameRoom);
                                        CusButTomSheet().sheet(
                                          context: context,
                                          indexRadio: lIndex,
                                          updateRadio: true,
                                          onTap: () {
                                            print("555555555555555555");
                                          },
                                          title:
                                              'แก้ไขข้อมูล ${data[lIndex].nameRoom}',
                                          ok: () {
                                            ref
                                                .read(roomProvider.notifier)
                                                .upDate(
                                                    name: name.text,
                                                    seat: chair.text,
                                                    price: monny.text,
                                                    index: lIndex,
                                                    context: context);
                                          },
                                          textFiled_1: FormEmail(
                                            icon: const Icon(
                                                Icons.paste_outlined),
                                            controller: name,
                                            textErr: 'กรุณากรอกชื่อห้อง',
                                            hintText: '',
                                          ),
                                          textFiled_3: FormEmail(
                                            icon: const Icon(
                                                Icons.monetization_on),
                                            controller: monny,
                                            textErr: 'กรุณากรอกราคา',
                                            hintText: '0',
                                          ),
                                          textFiled_2: FormEmail(
                                            icon: const Icon(
                                                Icons.chair_alt_sharp),
                                            controller: chair,
                                            textErr: 'กรุณากรอกจำนวนที่นั่ง',
                                            hintText: '0',
                                          ),
                                        );
                                      },
                                      child: const Text("แก้ไข")),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.87,
                          ),
                          child: IconButton(
                            onPressed: () {
                              ref
                                  .read(roomProvider.notifier)
                                  .delete(index: lIndex, context: context);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: const Color.fromARGB(255, 245, 7, 4),
                              size: MediaQuery.of(context).size.shortestSide *
                                  0.097,
                            ),
                          ))
                    ],
                  ),
                );
              },
            );
          } else {
            return const Text(
              textAlign: TextAlign.center,
              "No Room",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            );
          }
        },
        error: (error, stackTrace) {
          return Text(error.toString());
        },
        loading: () => const Text("Loading.."),
      ),
    );
  }
}
