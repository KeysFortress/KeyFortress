import 'package:domain/models/stored_secret.dart';

abstract class ISecretManager {
  String generateSecret({int length = 12});
  Future<List<StoredSecret>> getSecrets();
  Future<bool> setSecret(StoredSecret secret);
  Future<bool> importSecrets(List<StoredSecret> secrets);
}
