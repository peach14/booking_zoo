import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/custom_gridview_shanimal.dart';
import '../controller/show_animal_controller.dart';

class ListOfAnimals extends ConsumerStatefulWidget {
  const ListOfAnimals({Key? key}) : super(key: key);

  @override
  ConsumerState<ListOfAnimals> createState() => _ListOfAnimalsState();
}

class _ListOfAnimalsState extends ConsumerState<ListOfAnimals> {
  @override
  Widget build(BuildContext context) {
    final dataAnimal = ref.watch(shoAnimalProvider);
    return Container(
      color: Colors.blue.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dataAnimal.isEmpty)
            const Expanded(child: Text("ยังไม่มี สัตว์นะ")),
          if (dataAnimal.isNotEmpty)
            const Expanded(child: CustomGridViewShAnimal())
        ],
      ),
    );
  }
}
