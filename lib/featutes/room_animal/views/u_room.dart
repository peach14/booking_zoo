import 'package:booking_zoo/constants/asset/asset_phat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/select_icon.dart';
import '../controller/show_room_controller.dart';

class URoom extends ConsumerStatefulWidget {
  const URoom({Key? key}) : super(key: key);
  @override
  ConsumerState<URoom> createState() => _URoomState();
}

class _URoomState extends ConsumerState<URoom> {
  @override
  Widget build(BuildContext context) {
    final roomData = ref.watch(showRoomProvider);
    return Column(
      children: [
        if (roomData.isEmpty) const Text("ยังไม่มีห้อง โชว์"),
        if (roomData.isNotEmpty)
          Expanded(
            child: GridView.builder(
              itemCount: roomData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.shortestSide * 0.023),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 15,
                        backgroundColor: Colors.white,
                        shadowColor: Colors.black54,
                        foregroundColor: Colors.grey,
                        disabledBackgroundColor:
                            const Color.fromARGB(202, 36, 164, 22),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(
                              width: 0.9,
                              color: Color.fromARGB(255, 5, 5, 5),
                            )),
                        // surfaceTintColor: Colors.orange
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectIcon(
                                gane: roomData[index].gane,
                              ),
                            ));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.0),
                                  image: DecorationImage(
                                      image: AssetImage(ImagePhat.room),
                                      fit: BoxFit.fill),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  roomData[index].nameRoom,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ที่นั่ง ${roomData[index].seat.length} ที่",
                                      style: const TextStyle(
                                          //color: Colors.white,

                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ราคา ${roomData[index].price} /ที่นั่ง",
                                      style: const TextStyle(
                                          //color: Colors.white,
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                );
              },
            ),
          ),
      ],
    );
  }
}
