import 'package:booking_zoo/featutes/main/models/admin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/create_round_controller.dart';
import 'crud_round.dart';

class ManageTime extends ConsumerStatefulWidget {
  const ManageTime({
    super.key,
    required this.addData,
    required this.mainIndex,
  });

  final List<One> addData;
  final int mainIndex;
  @override
  ConsumerState<ManageTime> createState() => _ManageTimeState();
}

class _ManageTimeState extends ConsumerState<ManageTime> {
  TextEditingController nameAnimal = TextEditingController();
  TextEditingController nameRoom = TextEditingController();
  TextEditingController time = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 4, 204, 17),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.shortestSide * 0.015,
        left: MediaQuery.of(context).size.shortestSide * 0.02,
        right: MediaQuery.of(context).size.shortestSide * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color.fromARGB(255, 1, 19, 44)),
                onPressed: () {
                  add(index: widget.mainIndex);
                },
                child: const Row(
                  children: [
                    Icon(Icons.add),
                    Text("เพิ่มเวลาแสดง"),
                  ],
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6932,
            width: double.infinity,
            child: ListView.builder(
              itemCount: widget.addData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.015),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      update(index: index, mainIndex: widget.mainIndex);
                    },
                    child: ListTile(
                      leading: Text(widget.addData[index].animalRound),
                      title: Text(widget.addData[index].roomRound),
                      subtitle: Text(
                        widget.addData[index].time,
                        style: const TextStyle(color: Colors.green),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          delete(index: index, mainIndex: widget.mainIndex);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void add({required int index}) {
    CustomRoundController().addTimeShow(
      context: context,
      nameAnimal: nameAnimal,
      nameRoom: nameRoom,
      time: time,
      addData: widget.addData,
      onTap: () {
        ref.read(roundProvider.notifier).addDeTile(
            index: index,
            roomRound: nameRoom.text,
            animalRound: nameAnimal.text,
            time: time.text);
        Navigator.pop(context);
      },
    );
    nameAnimal.clear();
    nameRoom.clear();
    time.clear();
  }

  void update({required int index, required int mainIndex}) {
    TextEditingController editnameAnomal =
        TextEditingController(text: widget.addData[index].animalRound);
    TextEditingController editnameRoom =
        TextEditingController(text: widget.addData[index].roomRound);
    TextEditingController edittime =
        TextEditingController(text: widget.addData[index].time);
    CustomRoundController().editTimeShow(
        onTap: () {
          ref.read(roundProvider.notifier).updateDeTile(
              mainIndex: mainIndex,
              deTileIndex: index,
              roomRound: editnameRoom.text,
              animalRound: editnameAnomal.text,
              time: edittime.text);
          Navigator.pop(context);
        },
        addData: widget.addData,
        context: context,
        editNameAnimal: editnameAnomal,
        editNameRoom: editnameRoom,
        editTime: edittime,
        lIndex: index);
  }

  void delete({required int index, required int mainIndex}) {
    ref
        .read(roundProvider.notifier)
        .removeDeTile(mainIndex: mainIndex, deTileIndex: index);
    // CustomDiarlog().diarlog(
    //     context: context,
    //     title: "ลบรอบเวลาการแสดง",
    //     content1: widget.addData[index].animalRound,
    //     content2: "ห้อง ${widget.addData[index].roomRound}",
    //     content3: "เวลา ${widget.addData[index].time}",
    //     ok: () {
    //       ref
    //           .read(roundProvider.notifier)
    //           .removeDeTile(mainIndex: mainIndex, deTileIndex: index);
    //     });
  }
}
