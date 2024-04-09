import 'package:booking_zoo/featutes/round_booking/controller/show_round_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'u_round.dart';

class PageViewPage extends ConsumerWidget {
  const PageViewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final dataRound = ref.watch(showRoundProvider);
    List<Widget> listScreen = List.generate(
        dataRound.length,
        (mainIndex) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02,
                        right: MediaQuery.of(context).size.width * 0.02),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  backgroundColor:
                                      const Color.fromARGB(255, 1, 19, 44),
                                  disabledBackgroundColor:
                                      const Color.fromARGB(255, 1, 19, 44)),
                              onPressed: null,
                              child: Row(
                                children: [
                                  Text("รอบที่ ${mainIndex + 1}",
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.33,
                        ),
                        mainIndex == dataRound.length - 1
                            ? const SizedBox.shrink()
                            : const Text("รอบถัดไป ->")
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 14,
                  child: Container(
                    color: Colors.green,
                    child: ListView.builder(
                      itemCount: dataRound[mainIndex].one.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.015,
                              right: MediaQuery.of(context).size.width * 0.015,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.015),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              ref.read(showRoundProvider.notifier).selectRoom(
                                  nameRoom:
                                      dataRound[mainIndex].one[index].roomRound,
                                  nameAnimal: dataRound[mainIndex]
                                      .one[index]
                                      .animalRound);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => URound(
                                      timeShow:
                                          dataRound[mainIndex].one[index].time,
                                    ),
                                  ));
                            },
                            child: ListTile(
                              leading: Text(
                                  dataRound[mainIndex].one[index].animalRound),
                              title: Text(
                                  dataRound[mainIndex].one[index].roomRound),
                              trailing: Text(
                                dataRound[mainIndex].one[index].time,
                                style: const TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ));
    return Scaffold(
      body: PageView(children: listScreen),
    );
  }
}
