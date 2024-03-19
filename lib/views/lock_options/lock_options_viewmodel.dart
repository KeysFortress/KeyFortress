import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared/page_view_model.dart';

class LockOptionsViewModel extends PageViewModel {
  late IAuthorizationService _authorizationService;

  var disableLockError =
      "At least one authentication method must be enabled, if the lock option is enabled.";
  int _lockTime = 0;
  int get lockTime => _lockTime;

  DeviceLockType _deviceLockType = DeviceLockType.none;
  DeviceLockType get deviceLockType => _deviceLockType;

  bool _isTimeLockEnabled = false;
  bool get isTimeLockEnabled => _isTimeLockEnabled;

  bool _isMinimizeLockEnabled = false;
  bool get isMinimizeLockEnabled => _isMinimizeLockEnabled;

  bool _lockEnabled = false;
  bool get lockEnabled => _lockEnabled;

  LockOptionsViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
  }

  ready() async {
    _deviceLockType = await _authorizationService.getDeviceLockType();
    _isMinimizeLockEnabled =
        await _authorizationService.isMinimizeLockEnabled();
    _isTimeLockEnabled = await _authorizationService.isTimeLockEnabled();

    _lockTime = await _authorizationService.getTimeLockTime();
    _lockEnabled = await _authorizationService.isDeviceLockEnabled();

    notifyListeners();
  }

  void onEnabledChanged(bool value) async {
    await _authorizationService.setDeviceLockEnabled(value);
    _lockEnabled = value;
    notifyListeners();
  }

  onSubstractTime() async {
    if (_lockTime < 15) return;

    _lockTime = _lockTime - 15;
    await _authorizationService.setLockTime(_lockTime);
    notifyListeners();
  }

  onIncrementTime() async {
    _lockTime = _lockTime + 15;
    await _authorizationService.setLockTime(_lockTime);

    notifyListeners();
  }

  void onTimeBasedLockChanged(bool value) async {
    await _authorizationService.setLockTimeEnabled(value);
    _isTimeLockEnabled = value;
    notifyListeners();
  }

  void onMinimizeLockChanged(bool value) async {
    await _authorizationService.setMinimizeLockEnabled(value);
    _isMinimizeLockEnabled = value;
    notifyListeners();
  }

  onEnabledBiometric(bool state) async {
    checkDisabledState(state);
    LocalAuthentication auth = LocalAuthentication();

    var biometricSupported = await auth.getAvailableBiometrics();
    var enabled = biometricSupported.isNotEmpty &&
        biometricSupported.any((element) => element.name == "strong");

    if (!enabled)
      throw BaseException(
        context: pageContext,
        message: "Device doesn't support biometrics.",
      );

    await _authorizationService.enableBiometric();
  }

  onEnablePassword(bool state) {
    checkDisabledState(state);
    router.changePage(
      "/setup-pin",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }

  onEnabledPattern(bool state) {
    checkDisabledState(state);
    router.changePage(
      "/setup-pattern",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }

  checkDisabledState(bool state) {
    if (state == false && _lockEnabled)
      return BaseException(
        context: pageContext,
        message: disableLockError,
      );
  }
}
