import 'package:domain/models/enums.dart';
import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:presentation/page_view_model.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';

class DashboardHeaderViewModel extends PageViewModel {
  late ISecretManager _secretManager;
  late IIdentityManager _identityManager;
  DashboardHeaderViewModel(super.context) {
    observer.subscribe("active_page_changed", pageChanged);
    _secretManager = getIt.get<ISecretManager>();
    _identityManager = getIt.get<IIdentityManager>();
  }

  int _totalSaved = 20;
  get saved => _totalSaved;

  String _lastUsed = "--";
  String get lastUsed => _lastUsed;

  pageChanged(ActiveNavigationPage page) async {
    switch (page) {
      case ActiveNavigationPage.passwords:
        loadPasswords();
      case ActiveNavigationPage.syncMode:
      // TODO: Handle this case.
      case ActiveNavigationPage.identities:
        loadIdentities();
    }
  }

  void loadIdentities() async {
    var secrets = await _secretManager.getSecrets();
    _totalSaved = secrets.length;
    secrets.sort((a, b) => a.lastUsed.isAfter(b.lastUsed) == true ? 1 : 0);
    var lastDate = secrets.first.lastUsed;
    _lastUsed = "${lastDate.day}/${lastDate.month}/${lastDate.year}";
    notifyListeners();
  }

  void loadPasswords() async {
    var secrets = await _secretManager.getSecrets();
    _totalSaved = secrets.length;
    secrets.sort((a, b) => a.lastUsed.isAfter(b.lastUsed) == true ? 1 : 0);
    var lastDate = secrets.first.lastUsed;
    _lastUsed = "${lastDate.day}/${lastDate.month}/${lastDate.year}";
    notifyListeners();
  }
}
