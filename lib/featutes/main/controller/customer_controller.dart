import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/services/local_storage.dart';
import '../../auth/controler/auth_controller.dart';
import '../models/customer_model.dart';

class Customer extends AutoDisposeAsyncNotifier<CustomerModel> {
  @override
  build() {
    return loadData();
  }

  Future<CustomerModel> loadData() async {
    final session = ref.watch(sessionProvider);
    final data = await LocalStorage.instance.getDBUser();
    List<CustomerModel> cvInformation = userInformationFromJson(str: data!);

    CustomerModel? matchingUser;
    for (var user in cvInformation) {
      if (user.username == session.value) {
        matchingUser = user;
        break;
      }
    }
    return matchingUser ?? CustomerModel(username: 'nodata', data: []);
  }
}

final customerProvider =
    AsyncNotifierProvider.autoDispose<Customer, CustomerModel>(Customer.new);
