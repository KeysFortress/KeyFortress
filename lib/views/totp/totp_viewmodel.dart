import 'dart:async';

import 'package:domain/models/enums.dart';
import 'package:domain/models/otp_code.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:shared/page_view_model.dart';

class TotpViewModel extends PageViewModel {
  late IOtpService _otpService;
  List<OtpCode> _secrets = [];
  List<OtpCode> get secrets => _secrets;
  int _seconds = 60;
  int get seconds => _seconds;
  TotpViewModel(super.context) {
    _otpService = getIt.get<IOtpService>();
  }

  ready() async {
    _secrets = await _otpService.get();

    _seconds = DateTime.now().second;

    _secrets.forEach(
      (element) {
        Timer.periodic(Duration(seconds: 1), (timer) async {
          _seconds = 60 - DateTime.now().second;
          if (_seconds == element.interval) {
            var code = await _otpService.getCode(
              element.secret,
              element.interval ?? 60,
              element.algorithm,
            );
            _secrets.first.code = code;
            notifyListeners();
          }
        });
      },
    );

    notifyListeners();
  }

  onAddPressed() {
    router.changePage(
      "/add-topt-secret",
      pageContext,
      TransitionData(
        next: PageTransition.slideForward,
      ),
    );
  }

  onScanPressed() {
    router.changePage(
      "/add-totp",
      pageContext,
      TransitionData(
        next: PageTransition.slideForward,
      ),
    );
  }

  String getCode(OtpCode elementAt) {
    return _otpService.getCode(
      elementAt.secret,
      elementAt.interval ?? 30,
      elementAt.algorithm,
    );
  }

  onDeletePressed(OtpCode elementAt) async {
    await _otpService.remove(elementAt.secret);
    _secrets = await _otpService.get();
    notifyListeners();
  }
}
