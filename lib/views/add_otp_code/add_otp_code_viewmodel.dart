import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/otp_code.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:infrastructure/interfaces/isync_service.dart';
import 'package:shared/page_view_model.dart';

class AddOtpCodeViewModel extends PageViewModel {
  late IOtpService _otpService;
  late ISyncService _syncService;
  bool _isSyncOnTotpEnabled = true;
  AddOtpCodeViewModel(super.context) {
    _otpService = getIt.get<IOtpService>();
    _syncService = getIt.get<ISyncService>();
  }

  ready() async {
    var settings = await _syncService.getGlobalSettings();
    _isSyncOnTotpEnabled = settings["onAction"] && settings["onTotp"];
  }

  onScanComplete(String qrLink) async {
    if (!qrLink.contains("otpauth://totp/")) {
      throw BaseException(context: pageContext, message: "Invalid QR Link");
    }

    var otpLink = OtpCode.fromQrCodeLink(qrLink);
    if (otpLink.secret.isEmpty) {
      throw BaseException(context: pageContext, message: "Invalid QR Link");
    }

    await _otpService.add(otpLink);

    if (_isSyncOnTotpEnabled) observer.getObserver("sync_changes", null);

    router.backToPrevious(pageContext);
  }
}
