import 'package:domain/converters/binary_converter.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:presentation/page_view_model.dart';

class ManualSignBoxViewModel extends PageViewModel {
  late ISignatureService _signatureService;
  StoredIdentity identity;
  late String _message;
  late String _data;
  ManualSignBoxViewModel(super.context, this.identity) {
    _signatureService = getIt.get<ISignatureService>();
  }

  onMessageChanged(String message) {
    _message = message;
  }

  onDataChanged(String data) {
    _data = data;
  }

  void onSave() async {
    var getKeyData = await _signatureService.importKeyPair(
      identity.publicKey,
      identity.privateKey,
    );

    var signature = await _signatureService.signMessage(getKeyData, _message);

    print(signature.publicKey);
    print(signature.bytes);
  }
}
