import 'dart:convert';
import 'package:domain/converters/binary_converter.dart';
import 'package:domain/models/http_request.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import '../../../KF_Shared/lib/page_view_model.dart';
import 'package:domain/models/qr_code_data.dart';

class StartAuthViewModel extends PageViewModel {
  late IHttpProviderService _provider;
  late StoredIdentity _identity;
  late ISignatureService _signatureService;

  StartAuthViewModel(super.context) {
    _provider = getIt.get<IHttpProviderService>();
    _signatureService = getIt.get<ISignatureService>();
    _identity = router.getPageBindingData() as StoredIdentity;
  }

  /*
  0:
  "FinishChallenge" -> "https://localhost:7095/API/V1/Authentication/finish-handshake"
  1:
  "Initial" -> "https://localhost:7095/API/V1/Authentication/init-handshake"
  2:
  "ForUser" -> "47303bc6-b380-4b05-9a7e-8ccd9f16a2df"
  */
  onScanComplete(String result) async {
    try {
      var jsonData = jsonDecode(result);
      var qrData = QrCodeData.fromJson(jsonData);
      var importIdentity = await _signatureService.importKeyPair(
        _identity.publicKey,
        _identity.privateKey,
      );

      //TODO prompt the identity menu
    } catch (ex) {
      //TODO go to failed
    }
  }
}
