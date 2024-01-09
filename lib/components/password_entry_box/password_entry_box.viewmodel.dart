import 'package:domain/models/enums.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:presentation/page_view_model.dart';

class PasswordEntryBoxViewModel extends PageViewModel {
  late ISecretManager _secretManager;
  final String password;
  late String _name;
  late String _email;

  PasswordEntryBoxViewModel(super.context, this.password) {
    _secretManager = getIt.get<ISecretManager>();
  }

  onNameChanged(String name) {
    _name = name;
  }

  onEmailChanged(String email) {
    _email = email;
  }

  void onSave() async {
    var result = await _secretManager.setSecret(
      StoredSecret(
        name: _name,
        username: _email,
        content: password,
        lastUsed: DateTime.now(),
        secretType: SecretType.password,
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
