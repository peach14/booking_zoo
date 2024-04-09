import 'package:booking_zoo/featutes/room_animal/controller/show_room_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main/view/usersceen.dart';

class AnimalInType extends ConsumerStatefulWidget {
  const AnimalInType({
    super.key,
  });

  @override
  ConsumerState<AnimalInType> createState() => _AnimalInTypeState();
}

class _AnimalInTypeState extends ConsumerState<AnimalInType> {
  @override
  Widget build(BuildContext context) {
    final dataAnimal = ref.watch(thisGeneAnimal);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("สัตว์ประเภท ${dataAnimal.last.gene}"),
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
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: dataAnimal.length,
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
                                        child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 60),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      topRight:
                                                          Radius.circular(12)),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      dataAnimal[index]
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
                                                dataAnimal[index].nameAnimal,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Spacer(),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "ชนิด : ${dataAnimal[index].type}",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .shortestSide *
                                                              0.035),
                                                    ),
                                                    Text(
                                                      "สายพันธุ์ : ${dataAnimal[index].gene}",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .shortestSide *
                                                              0.035),
                                                    ),
                                                    Text(
                                                      "เวลาโชว์ : ${dataAnimal[index].timeShow}",
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
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
