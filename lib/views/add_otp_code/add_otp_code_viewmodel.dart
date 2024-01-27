import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/otp_code.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:shared/page_view_model.dart';

class AddOtpCodeViewModel extends PageViewModel {
  late IOtpService _otpService;

  AddOtpCodeViewModel(super.context) {
    _otpService = getIt.get<IOtpService>();
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
    router.backToPrevious(pageContext);
  }
}
