import 'package:components/identity_entry_box/identity_entry_box.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:shared/page_view_model.dart';

class IdentitiesViewModel extends PageViewModel {
  late IIdentityManager _identityManager;

  List<StoredIdentity> _identities = [];
  List<StoredIdentity> get identities => _identities;

  IdentitiesViewModel(super.context) {
    _identityManager = getIt.get<IIdentityManager>();
  }

  ready() async {
    _identities = await _identityManager.getSecrets();
    observer.getObserver("on_menu_state_changed", true);

    notifyListeners();
  }

  onGenerateCertificate() async {
    var result = await _identityManager.generateIdentity();
    print(result.publicKey);
    print(result.privateKey);
    router.openBar(
      IdentityEntryBox(
        keyData: result,
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
