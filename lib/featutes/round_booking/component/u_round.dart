import 'package:booking_zoo/featutes/round_booking/controller/show_round_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class URound extends ConsumerStatefulWidget {
  const URound({
    Key? key,
    required this.timeShow,
  }) : super(key: key);

  final String timeShow;

  @override
  ConsumerState<URound> createState() => _URoundState();
}

class _URoundState extends ConsumerState<URound> {
  bool genQe = false;
  @override
  Widget build(BuildContext context) {
    final dataRoom = ref.watch(onlyRoom);
    final dataAnimal = ref.watch(onlyAnimal);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(dataRoom.nameRoom),
        ),
        body: Container(
          padding:
              EdgeInsets.all(MediaQuery.of(context).size.shortestSide * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "${dataRoom.nameRoom} \nเวลา ${widget.timeShow} | ${dataAnimal.nameAnimal} เวลาโชว์ ${dataAnimal.timeShow}"),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("เลือกที่นั่งของคุณ"),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: double.infinity,
                  child: GridView.builder(
                    itemCount: dataRoom.seat.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      backgroundColor: const Color.fromARGB(
                                          202, 213, 210, 210),
                                      padding: const EdgeInsets.all(9),
                                      elevation: 0),
                                  onPressed: () {
                                    dataRoom.seat[index].sttus =
                                        !dataRoom.seat[index].sttus;
                                    dataRoom.seat.forEach((element) {
                                      print(element.sttus);
                                    });

                                    setState(() {});
                                  },
                                  child: Icon(Icons.person,
                                      color: dataRoom.seat[index].sttus == false
                                          ? Colors.black
                                          : Colors.red)),
                              Text(
                                dataRoom.seat[index].value,
                                style: const TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text("ที่นั่งละ ${dataRoom.price} บาท"),
                ElevatedButton(
                    onPressed: () {
                      genQe = true;
                      setState(() {});
                      ref.read(showRoundProvider.notifier).save(
                          nameRoom: dataRoom.nameRoom, seat: dataRoom.seat);
                    },
                    child: const Text('ชำระเงิน')),
                genQe ? qr(dataRoom.price) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column qr(String dataQR) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      QrImageView(
        data: dataQR,
        size: MediaQuery.of(context).size.shortestSide * 0.32,
        backgroundColor: Colors.white,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
    ]);
  }
}
