import 'dart:convert';

import 'package:domain/converters/binary_converter.dart';
import 'package:domain/models/http_request.dart';
import 'package:domain/models/signature_event.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:infrastructure/interfaces/isignature_store.dart';
import 'package:presentation/page_view_model.dart';
import 'package:cryptography/src/cryptography/signature.dart';

class ManualSignBoxViewModel extends PageViewModel {
  late ISignatureService _signatureService;
  late IHttpProviderService _providerService;
  late ISignatureStore _store;

  Function onSaveCallback;
  StoredIdentity identity;
  String _message = "";
  String get message => _message;

  late String _data;

  Signature? _signature = null;
  Signature? get signature => _signature;

  String _url = "";
  String _bearer = "";

  ManualSignBoxViewModel(super.context, this.identity, this.onSaveCallback) {
    _signatureService = getIt.get<ISignatureService>();
    _store = getIt.get<ISignatureStore>();
  }

  bool _advanced = false;
  get advanced => _advanced;

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

    _signature = await _signatureService.signMessage(getKeyData, _message);

    print(_signature!.publicKey);
    print(_signature!.bytes);

    _store.add(
      SignatureEvent(
        identity.publicKey,
        BianaryConverter.toHex(_signature!.bytes),
        _message,
        _data,
      ),
    );

    notifyListeners();
  }

  onAdvancedPressed() {
    _advanced = true;
    notifyListeners();
  }

  onCopySignature() {
    Clipboard.setData(
      ClipboardData(
        text: BianaryConverter.toHex(_signature!.bytes),
      ),
    );
  }

  onCopyPublic() {
    Clipboard.setData(
      ClipboardData(
        text: identity.publicKey,
      ),
    );
  }

  onUrlChanged(String url) {
    _url = url;
  }

  onBearerChanged(String bearer) {
    _bearer = bearer;
  }

  onClose() {
    onSaveCallback.call();
  }

  onSend() async {
    var result = await _providerService.postRequest(
      HttpRequest(
        _url,
        _advanced ? {"Authorized": "Bearer ${_bearer}"} : {},
        jsonEncode({
          "signature": BianaryConverter.toHex(_signature!.bytes),
          "data": _data,
        }),
      ),
    );
    if (result == null || result.statusCode == 200) {
      //TODO log errors
    }

    onSaveCallback.call();
  }
}
