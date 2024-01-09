import 'package:application/implementations/signature_service.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:domain/models/key_dto.dart';
import 'package:domain/converters/binary_converter.dart';

class IdentityManager implements IIdentityManager {
  late ISignatureService _signatureService;
  late IlocalStorage _localStorage;
  IdentityManager(ISignatureService signatureService, IlocalStorage storage) {
    _signatureService = signatureService;
    _localStorage = storage;
  }

  @override
  Future<KeyDto> generateIdentity() async {
    var result = await _signatureService.generatePrivateKey();
    var privateKeyData = await result.extractPrivateKeyBytes();
    var publicKeyData = await result.extractPublicKey();
    var key = publicKeyData.bytes;

    return KeyDto(
      publicKey: BianaryConverter.toHex(privateKeyData),
      privateKey: BianaryConverter.toHex(key),
    );
  }

  @override
  Future<List<StoredIdentity>> getSecrets() {
    // TODO: implement getSecrets
    throw UnimplementedError();
  }

  @override
  Future<bool> importSecrets(List<StoredIdentity> secrets) {
    // TODO: implement importSecrets
    throw UnimplementedError();
  }

  @override
  Future<bool> setSecret(StoredIdentity secret) {
    // TODO: implement setSecret
    throw UnimplementedError();
  }
}
