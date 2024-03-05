import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/otp_code.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:shared/page_view_model.dart';

class SetupTotpLockViewModel extends PageViewModel {
  late IAuthorizationService _authorizationService;
  String _secret = "";
  SetupTotpLockViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
  }

  onScanComplete(String secret) async {
    if (!secret.contains("otpauth://totp/")) {
      throw BaseException(context: pageContext, message: "Invalid QR Link");
    }

    var otpLink = OtpCode.fromQrCodeLink(secret);
    _secret = otpLink.secret;

    var setLockType = await _authorizationService.setDeviceLockType(
      DeviceLockType.totp,
      value: _secret,
    );
    if (!setLockType) {
      throw BaseException(context: pageContext, message: "Invalid QR Link");
    }
    router.router.router.go("/lock");
  }

  onSecretChanged(String secret) async {
    _secret = secret;
  }

  onSaveChanges() async {
    if (!_secret.contains("otpauth://totp/")) {
      throw BaseException(context: pageContext, message: "Invalid Link");
    }

    var otpLink = OtpCode.fromQrCodeLink(_secret);
    _secret = otpLink.secret;

    var setLockType = await _authorizationService.setDeviceLockType(
      DeviceLockType.totp,
      value: _secret,
    );
    if (!setLockType) {
      throw BaseException(context: pageContext, message: "Invalid Link");
    }

    router.router.router.go("/lock");
  }
}
