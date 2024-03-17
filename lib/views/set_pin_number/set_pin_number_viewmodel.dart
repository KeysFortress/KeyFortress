import 'package:domain/models/enums.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:shared/page_view_model.dart';

class SetPinNumberViewModel extends PageViewModel {
  String _password = "";
  String get password => _password;

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  bool _isConfirm = false;
  bool get isConfirm => _isConfirm;
  String _enteredPassword = "";
  late IAuthorizationService _authorizationService;

  SetPinNumberViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
  }

  buttonPressed(int number) async {
    if (_password.length >= 6) return;

    _password += number.toString();

    if (_password.length == 6 && _isConfirm && _password == _enteredPassword) {
      await _authorizationService.setDeviceLockType(
        DeviceLockType.password,
        value: _password,
      );
      router.isLocked = false;

      router.router.router.go("/dashboard");
    }

    if (_password.length == 6 && !_isConfirm) {
      _enteredPassword = _password;
      _password = "";
      _isConfirm = true;
    }

    notifyListeners();
  }

  onRemovePressed() {
    _password = _password.substring(0, _password.length - 1);

    notifyListeners();
  }

  onChangeVisability() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }
}
