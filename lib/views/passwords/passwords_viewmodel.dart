import 'package:components/password_entry_box/password_entry_box.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:infrastructure/interfaces/icloud_service.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:shared/page_view_model.dart';
import 'package:infrastructure/interfaces/ICloudSecrets_service.dart';

class PasswordsViewModel extends PageViewModel {
  late ISecretManager _secretManger;
  late ICloudService _cloudService;
  late ICloudSecretsService _cloudSecretsService;

  List<StoredSecret> _secrets = [];
  List<StoredSecret> get secrets => _secrets;

  PasswordsViewModel(super.context) {
    _secretManger = getIt.get<ISecretManager>();
    _cloudService = getIt.get<ICloudService>();
  }

  ready() async {
    List<StoredSecret> cloudSecrets = [];
    var connections = await _cloudService.connections();
    if (connections.isNotEmpty) {
      for (var connection in connections) {
        var connectionSecrets = await _cloudSecretsService.get(connection);
        cloudSecrets.addAll(connectionSecrets);
      }
    }

    _secrets = await _secretManger.getSecrets();
    _secrets.addAll(cloudSecrets);
    observer.getObserver("on_menu_state_changed", true);
    notifyListeners();
  }

  onGeneratePassword() {
    var password = _secretManger.generateSecret();
    router.openBar(
      PasswordEntryBox(
        password: password,
        onSave: onSave,
      ),
      pageContext,
    );
  }

  onSave() async {
    router.dismissBar(pageContext);
    await ready();
  }
}
