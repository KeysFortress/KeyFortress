import 'package:domain/models/signature_event.dart';

abstract class ISignatureStore {
  Future<List<SignatureEvent>> get();
  add(SignatureEvent event);
  remove(SignatureEvent event);
}
