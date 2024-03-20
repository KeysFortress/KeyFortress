import 'package:domain/exceptions/base_exception.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:infrastructure/interfaces/idevices_service.dart';
import 'package:infrastructure/interfaces/ilocal_network_service.dart';
import 'package:shared/page_view_model.dart';

class DeviceSettingViewModel extends PageViewModel {
  late ILocalNetworkService _localNetworkService;
  late IAuthorizationService _authorizationService;

  String _deviceName = "";
  String get deviceName => _deviceName;

  bool _isSelfDestructEnabled = false;
  bool get isSelfDestructEnabled => _isSelfDestructEnabled;

  int _totalAttempts = 3;
  get totalAttempts => _totalAttempts;

  DeviceSettingViewModel(super.context) {
    _localNetworkService = getIt.get<ILocalNetworkService>();
    _authorizationService = getIt.get<IAuthorizationService>();
  }

  ready() async {
    var deviceData = await _localNetworkService.getNetworkData();
    _deviceName = deviceData.name;
    _isSelfDestructEnabled =
        await _authorizationService.selfDestructActivated();
    notifyListeners();
  }

  onDeviceNameChanged(String name) async {
    if (name.isEmpty) return;

    await _localNetworkService.overrideDeviceName(name);
    _deviceName = name;
  }

  void onSelfDestructStateChanged(bool value) async {
    _isSelfDestructEnabled = value;
    await _authorizationService.setSelfDestructState(value);
    notifyListeners();
  }

  onIncrementAttepmt() async {
    if (!_isSelfDestructEnabled) return;

    _totalAttempts = _totalAttempts + 1;
    await _authorizationService.setSelfDestructAttempts(_totalAttempts);

    notifyListeners();
  }

  onSubstractAttempt() async {
    if (!_isSelfDestructEnabled) return;

    if (_totalAttempts < 4) {
      throw BaseException(
        context: pageContext,
        message:
            "Minimum number of attempts reached, the number has to be greater than 3",
      );
    }

    _totalAttempts = _totalAttempts - 1;
    await _authorizationService.setSelfDestructAttempts(_totalAttempts);

    notifyListeners();
  }
}
