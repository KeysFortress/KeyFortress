import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:shared/page_view_model.dart';

class DashboardViewModel extends PageViewModel {
  late IIdentityManager _identityManager;
  late ISecretManager _secretManager;
  late IOtpService _otpService;

  int _identities = 0;
  int get identities => _identities;

  int _secrets = 0;
  int get secrets => _secrets;

  int _otpSecrets = 0;
  int get optSecrets => _otpSecrets;

  int _personalSecrets = 0;
  int get personalSecrets => _personalSecrets;

  int _rlc = 0;
  int get rlc => _rlc;

  int _rac = 0;
  int get rac => _rac;

  DashboardViewModel(super.context) {
    _identityManager = getIt.get<IIdentityManager>();
    _secretManager = getIt.get<ISecretManager>();
    _otpService = getIt.get<IOtpService>();
  }

  ready() async {
    var identities = await _identityManager.getSecrets();
    var secrets = await _secretManager.getSecrets();
    var otpSecrets = await _otpService.get();

    _identities = identities.length;
    _secrets = secrets.length;
    _otpSecrets = otpSecrets.length;

    notifyListeners();
  }
}
