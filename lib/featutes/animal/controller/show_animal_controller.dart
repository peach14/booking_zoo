import 'package:booking_zoo/featutes/animal/controller/create_animal_controller.dart';
import 'package:booking_zoo/featutes/main/models/admin_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowAnimalController extends Notifier<List<Animal>> {
  @override
  build() {
    return loadData() ?? [];
  }

  List<Animal>? loadData() {
    final dataAnimal = ref.watch(animalProvider);
    return dataAnimal.value;
  }
}

final shoAnimalProvider = NotifierProvider<ShowAnimalController, List<Animal>>(
    ShowAnimalController.new);
