import 'package:infrastructure/interfaces/isync_service.dart';
import 'package:shared/page_view_model.dart';

class SyncSettingsViewModel extends PageViewModel {
  late ISyncService _syncService;

  SyncSettingsViewModel(super.context) {
    _syncService = getIt.get<ISyncService>();
  }

  int _syncTime = 60;
  int get syncTime => _syncTime;

  bool _enabled = false;
  get enabled => _enabled;

  bool _syncOnAction = false;
  get syncOnAction => _syncOnAction;

  bool _afterPasswordActionEnabled = false;
  get afterPasswordActionEnabled => _afterPasswordActionEnabled;

  bool _onAfterIdentityActionEnabled = false;
  get onAfterIdentityActionEnabled => _onAfterIdentityActionEnabled;

  bool _onAfterSecretActionEnabled = false;
  get onAfterSecretActionEnabled => _onAfterSecretActionEnabled;

  bool _onAfterRacActionEnabled = false;
  get onAfterRacActionEnabled => _onAfterRacActionEnabled;

  bool _onAfterTotpActionEnabled = false;
  get onAfterTotpActionEnabled => _onAfterTotpActionEnabled;

  bool _onAfterRlcActionEnabled = false;
  get onAfterRlcActionEnabled => _onAfterRlcActionEnabled;

  bool _onSyncOnConnectionEnabled = false;
  get onSyncOnConnectionEnabled => _onSyncOnConnectionEnabled;

  bool _onTimeBasedEnabled = false;
  get onTimeBasedEnabled => _onTimeBasedEnabled;

  ready() async {
    var settings = await _syncService.getGlobalSettings();
    _syncTime = settings['updateTime'];
    _enabled = settings['enabled'];
    _syncOnAction = settings["onAction"];
    _afterPasswordActionEnabled = settings["onPassword"];
    _onAfterIdentityActionEnabled = settings["onIdentity"];
    _onAfterSecretActionEnabled = settings["onSecret"];
    _onAfterRacActionEnabled = settings["onRac"];
    _onAfterRlcActionEnabled = settings["onRlc"];
    _onAfterTotpActionEnabled = settings["onTotp"];
    _onSyncOnConnectionEnabled = settings["onConnection"];
    _onTimeBasedEnabled = settings["timeBasedSync"];

    notifyListeners();
  }

  void onSyncStateChanged(bool value) async {
    _enabled = value;
    await _syncService.setServiceState(value);
    notifyListeners();
  }

  void onSyncOnActionChanged(bool value) async {
    _syncOnAction = value;
    await _syncService.setSyncOnAction(value);
    notifyListeners();
  }

  void onAfterPasswordActionChanged(bool value) async {
    _afterPasswordActionEnabled = value;
    await _syncService.setPasswordAction(value);
    notifyListeners();
  }

  void onAfterIdentityChanged(bool value) async {
    _onAfterIdentityActionEnabled = false;
    await _syncService.setIdentityAction(value);
    notifyListeners();
  }

  void onAfterSecretAction(bool value) async {
    _onAfterSecretActionEnabled = value;
    await _syncService.setSecretAction(value);
    notifyListeners();
  }

  void onAfterRacActionChanged(bool value) async {
    _onAfterRacActionEnabled = value;
    await _syncService.setRacAction(value);
    notifyListeners();
  }

  void onAfterRlcActionChanged(bool value) async {
    _onAfterRlcActionEnabled = value;
    await _syncService.setRlcAction(value);
    notifyListeners();
  }

  void onAfteToTpActinChanged(bool value) async {
    _onAfterTotpActionEnabled = value;
    await _syncService.setTotpAction(value);
    notifyListeners();
  }

  void onSyncOnCoonnectionChanged(bool value) async {
    _onSyncOnConnectionEnabled = value;
    await _syncService.onConnectionAction(value);
    notifyListeners();
  }

  void onTimeBasedActionChanged(bool value) async {
    _onTimeBasedEnabled = value;
    await _syncService.setTimeBasedSyncAction(value);
  }

  onSubstractTime() async {
    if (_syncTime < 30) return;

    _syncTime = _syncTime - 15;
    await _syncService.updateTimeToSync(_syncTime);
  }

  onIncrementTime() async {
    _syncTime = _syncTime + 15;
    await _syncService.updateTimeToSync(_syncTime);
  }
}
