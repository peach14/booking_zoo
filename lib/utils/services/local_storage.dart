import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constanst.dart';

class LocalStorage {
  LocalStorage._();
  static final instance = LocalStorage._();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //save SessionLogin
  void saveSession({required String session}) async {
    final perf = await _prefs;
    perf.setString(KeyPerf.instance.session, session);
  }

  //get SessionLogin
  Future<String?> getSession() async {
    final perf = await _prefs;
    return perf.getString(KeyPerf.instance.session);
  }

  //delete SessionLogin
  deleteSession() async {
    final perf = await _prefs;
    return perf.remove(KeyPerf.instance.session);
  }

  //save Database User
  setDBUser({required List<String> data}) async {
    final perf = await _prefs;
    return perf.setStringList(KeyPerf.instance.dBUser, data);
  }

  //get Database User
  Future<List<String>?> getDBUser() async {
    final perf = await _prefs;
    return perf.getStringList(KeyPerf.instance.dBUser);
  }

  //delete Database User
  deleteDatabaseUser() async {
    final perf = await _prefs;
    return perf.remove(KeyPerf.instance.dBUser);
  }

  //save Database Admin
  setDBAdmin({required String data}) async {
    final perf = await _prefs;
    return perf.setString(KeyPerf.instance.dBAdmin, data);
  }

  //get Database Admin
  Future<String?> getDBAdmin() async {
    final perf = await _prefs;
    return perf.getString(KeyPerf.instance.dBAdmin);
  }

  //delete Database Admin
  deleteDBAdmin() async {
    final perf = await _prefs;
    return perf.remove(KeyPerf.instance.dBAdmin);
  }
}
