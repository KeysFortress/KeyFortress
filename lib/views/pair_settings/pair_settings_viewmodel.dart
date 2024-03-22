import 'package:basic_utils/basic_utils.dart';
import 'package:infrastructure/interfaces/icertificate_service.dart';
import 'package:shared/page_view_model.dart';

class PairSettingsViewModel extends PageViewModel {
  late ICertificateService _certificateService;

  List<X509CertificateData>? _x509certificateData;
  List<X509CertificateData>? get certificateData => _x509certificateData;

  bool _pairEnabled = true;
  get pairEnabled => _pairEnabled;

  PairSettingsViewModel(super.context) {
    _certificateService = getIt.get<ICertificateService>();
  }

  read() async {
    _x509certificateData = await _certificateService.read();
    notifyListeners();
  }

  void onEnabledChanged(bool value) {}

  onPortNumberChanged(String number) {}

  onUpdateCertificate() {}
}
