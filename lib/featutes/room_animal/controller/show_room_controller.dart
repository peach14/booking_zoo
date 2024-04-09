import 'package:booking_zoo/featutes/animal/controller/show_animal_controller.dart';
import 'package:booking_zoo/featutes/main/models/admin_model.dart';
import 'package:booking_zoo/featutes/room_animal/controller/create_room_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowRoomController extends Notifier<List<Room>> {
  @override
  build() {
    return loadData() ?? [];
  }

  List<Room>? loadData() {
    final dataRoom = ref.watch(roomProvider);
    return dataRoom.value;
  }

  void selectGene({required String gene}) {
    final getAnimal = ref.watch(shoAnimalProvider);
    ref.read(thisGeneAnimal.notifier).update((state) =>
        state = getAnimal.where((element) => element.gene == gene).toList());
  }
}

final thisGeneAnimal = StateProvider<List<Animal>>((ref) => []);
final showRoomProvider =
    NotifierProvider<ShowRoomController, List<Room>>(ShowRoomController.new);
