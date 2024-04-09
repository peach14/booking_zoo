import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/show_animal_controller.dart';

class CustomGridViewShAnimal extends ConsumerWidget {
  const CustomGridViewShAnimal({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final dataAnimal = ref.watch(shoAnimalProvider);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        constraints: const BoxConstraints(maxHeight: 300),
                        child: Material(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          elevation: 10,
                          child: InkWell(
                              child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 60),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            dataAnimal[index].imagePath),
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
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        children: [
                                          Text(
                                            "ชนิด : ${dataAnimal[index].type}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .shortestSide *
                                                    0.035),
                                          ),
                                          Text(
                                            "สายพันธุ์ : ${dataAnimal[index].gene}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .shortestSide *
                                                    0.035),
                                          ),
                                          Text(
                                            "เวบาโชว์ : ${dataAnimal[index].timeShow}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
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
    );
  }
}
