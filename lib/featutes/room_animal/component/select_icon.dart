import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main/view/usersceen.dart';
import '../controller/show_room_controller.dart';
import 'r_in_animal.dart';

class SelectIcon extends ConsumerStatefulWidget {
  const SelectIcon({
    super.key,
    required this.gane,
  });

  final List<dynamic> gane;

  @override
  ConsumerState<SelectIcon> createState() => _SelectIconState();
}

class _SelectIconState extends ConsumerState<SelectIcon> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ประเภทสัตว์'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserScreen(),
                      ));
                },
                icon: const Icon(Icons.home_outlined))
          ],
        ),
        body: Container(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "ประเภทสัตว์ในวันนี้",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.shortestSide * 0.05),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.14,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.gane.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor:
                                        const Color.fromARGB(202, 36, 164, 22),
                                    padding: const EdgeInsets.all(9),
                                    elevation: 0),
                                onPressed: () {
                                  ref
                                      .read(showRoomProvider.notifier)
                                      .selectGene(gene: widget.gane[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AnimalInType(),
                                      ));
                                },
                                child: const Icon(Icons.adb_sharp)),
                            Text(
                              widget.gane[index],
                              style: const TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
