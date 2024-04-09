import 'package:booking_zoo/featutes/main/models/admin_model.dart';
import 'package:booking_zoo/utils/services/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'customer_controller.dart';

final dataAdmin = FutureProvider<String>((ref) async {
  final getData = await LocalStorage.instance.getDBAdmin();
  final cvData = adMinFromJson(str: getData ?? '');
  return cvData.useName;
});
final dataCustomer = StateProvider.autoDispose<String>((ref) {
  final getData = ref.watch(customerProvider);
  return getData.maybeWhen(
    orElse: () => "",
    data: (data) => data.username,
  );
});
