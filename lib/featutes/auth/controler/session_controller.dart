part of 'auth_controller.dart';

class Session extends AsyncNotifier<String> {
  @override
  build() async {
    await Future.delayed(const Duration(seconds: 5));
    return loadSession();
  }

  void save({required String idName}) async {
    LocalStorage.instance.saveSession(session: idName);
    state = AsyncData(await loadSession());
  }

  void saveDBUser({required String idName}) async {
    final data = await LocalStorage.instance.getDBUser();
    if (data != null) {
      List<CustomerModel> cvInformation = userInformationFromJson(str: data);

      if (cvInformation.every((info) => info.username != idName) == true) {
        cvInformation.add(CustomerModel(
            username: idName, data: [Datum(booking: [], paid: false)]));
        LocalStorage.instance
            .setDBUser(data: userInformationToJson(cvInformation));
        print("newwwwwwwwwwwwwwwwwww");
      }
    } else {
      final newData = userInformationFromJson(str: data ?? []);
      newData.add(CustomerModel(
          username: idName, data: [Datum(booking: [], paid: false)]));
      LocalStorage.instance.setDBUser(data: userInformationToJson(newData));
      print(newData);
    }
  }

  void saveDBAdmin({required String idName}) async {
    final data = await LocalStorage.instance.getDBAdmin();
    if (data == null) {
      LocalStorage.instance.setDBAdmin(
          data: adMinToJson(
              AdminModel(useName: idName, round: [], room: [], animal: [])));
      print("newwwwwwwwwwwwwwwwwww");
    }
  }

  Future<String> loadSession() async {
    final data = await LocalStorage.instance.getSession();
    if (data == null) {
      return '';
    } else {
      return data;
    }
  }

  void delete() async {
    await LocalStorage.instance.deleteSession();
    state = AsyncData(await loadSession());
  }
}

final sessionProvider = AsyncNotifierProvider<Session, String>(Session.new);
