import 'package:domain/models/enums.dart';
import 'package:domain/models/otp_code.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:presentation/page_view_model.dart';

class TotpViewModel extends PageViewModel {
  late IOtpService _otpService;
  List<OtpCode> _secrets = [];
  List<OtpCode> get secrets => _secrets;

  TotpViewModel(super.context) {
    _otpService = getIt.get<IOtpService>();
  }

  ready() async {
    _secrets = await _otpService.get();
    notifyListeners();
  }

  onAddPressed() {
    router.changePage(
      "/add-totp",
      pageContext,
      TransitionData(
        next: PageTransition.slideForward,
      ),
    );
  }
}
