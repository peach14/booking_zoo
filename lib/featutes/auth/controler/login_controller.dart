import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared_components/form_email.dart';
import 'auth_controller.dart';

class Login extends AutoDisposeAsyncNotifier<bool> {
  @override
  build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  void validator({
    required String username,
    required String pass,
  }) async {
    if (pass != '1234') {
      ref.read(passErr.notifier).update((state) => true);
    } else {
      ref.read(passErr.notifier).update((state) => false);
      if (username.isNotEmpty) {
        if (username == 'admin') {
          //go admin
          ref.read(sessionProvider.notifier).save(idName: username);
          ref.read(sessionProvider.notifier).saveDBAdmin(idName: username);
        } else {
          //go user
          ref.read(sessionProvider.notifier).save(idName: username);
          ref.read(sessionProvider.notifier).saveDBUser(idName: username);
        }
      }
    }
  }

  void logOut() {
    ref.read(sessionProvider.notifier).delete();
  }
}

final loginProvider = AsyncNotifierProvider.autoDispose<Login, bool>(Login.new);
