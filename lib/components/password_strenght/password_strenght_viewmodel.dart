import 'package:presentation/page_view_model.dart';

class PasswordStrenghtViewModel extends PageViewModel {
  int _strenght = 1;
  int get strenght => _strenght;

  PasswordStrenghtViewModel(super.context, String? initial) {
    observer.subscribe("password_strenght_changed", onPasswordStrenghtChanged);
    if (initial != null) onPasswordStrenghtChanged(initial);
  }

  onPasswordStrenghtChanged(String password) {
    if (password.length < 8) {
      _strenght = 1;
      notifyListeners();
      return;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (hasUppercase && hasLowercase && hasNumber && hasSpecialChar) {
      _strenght = 4;
    }

    if (hasUppercase && hasLowercase && hasNumber && !hasSpecialChar) {
      _strenght = 3;
    }

    if (!hasUppercase && !hasLowercase && !hasNumber && !hasSpecialChar) {
      _strenght = 2;
      notifyListeners();
      return;
    }

    notifyListeners();
  }
}
