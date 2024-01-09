import 'dart:ui';

import 'package:domain/models/enums.dart';
import 'package:domain/models/key_dto.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:presentation/page_view_model.dart';

class IdentityEntryBoxViewModel extends PageViewModel {
  late IIdentityManager _identityManager;
  final KeyDto keyData;
  late String _name;
  late String _email;

  IdentityEntryBoxViewModel(super.context, this.keyData) {
    _identityManager = getIt.get<IIdentityManager>();
  }

  onNameChanged(String name) {
    _name = name;
  }

  void onSave() async {
    var result = await _identityManager.setSecret(
      StoredIdentity(
        _name,
        keyData.publicKey,
        keyData.privateKey,
      ),
    );
    if (result) {
      observer.getObserver(
        "reload_passwords",
        null,
      );
    }
  }
}
