import 'package:domain/models/otp_code.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:presentation/page_view_model.dart';

class AddOtpCodeViewModel extends PageViewModel {
  late IOtpService _otpService;

  AddOtpCodeViewModel(super.context) {
    _otpService = getIt.get<IOtpService>();
  }

  onScanComplete(String qrLink) async {
    var otpLink = OtpCode.fromQrCodeLink(qrLink);
    var otpCode = await _otpService.add(otpLink);
    print(otpCode.code);
  }
}
