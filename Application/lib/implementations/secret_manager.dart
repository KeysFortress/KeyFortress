import 'dart:convert';
import 'dart:math';

import 'package:domain/models/stored_secret.dart';

import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';

class SecretManger implements ISecretManager {
  final String lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
  final String uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final String digitChars = '0123456789';
  final String specialChars = r'!@#$%^&*()-_=+[]{}|;:,.<>?/';
  final IlocalStorage localStorage;

  SecretManger({required this.localStorage});

  @override
  String generateSecret({int length = 12}) {
    String allChars =
        lowercaseChars + uppercaseChars + digitChars + specialChars;
    Random random = Random.secure();
    List<String> passwordCharacters = List.generate(
        length, (index) => allChars[random.nextInt(allChars.length)]);
    passwordCharacters.shuffle();

    return passwordCharacters.join();
  }

  @override
  Future<List<StoredSecret>> getSecrets() async {
    var secretsData = await localStorage.get("secrets");
    if (secretsData == null) return [];

    List<dynamic> data = jsonDecode(secretsData);
    List<StoredSecret> result = [];
    data.forEach((element) {
      var current = StoredSecret.fromJson(element);
      result.add(current);
    });

    return result;
  }

  @override
  Future<bool> importSecrets(List<StoredSecret> secrets) async {
    var secretsData = await localStorage.get("secrets");
    if (secretsData == null) return false;

    List<dynamic> data = jsonDecode(secretsData);
    List<StoredSecret> result = [];
    data.forEach((element) {
      var current = StoredSecret.fromJson(element);
      result.add(current);
    });
    secrets.forEach((element) {
      result.add(element);
    });
    var json = result.map((e) => e.toJson()).toList();
    var jsonData = jsonEncode(json);
    await localStorage.set("secrets", jsonData);
    return true;
  }

  @override
  Future<bool> setSecret(StoredSecret secret) async {
    var secretsData = await localStorage.get("secrets");
    if (secretsData == null) {
      List<StoredSecret> result = [];
      result.add(secret);
      var json = result.map((e) => e.toJson()).toList();
      var jsonData = jsonEncode(json);
      await localStorage.set("secrets", jsonData);
      return true;
    }

    List<dynamic> data = jsonDecode(secretsData);
    List<StoredSecret> result = [];
    data.forEach((element) {
      var current = StoredSecret.fromJson(element);
      result.add(current);
    });

    result.add(secret);
    var json = result.map((e) => e.toJson()).toList();
    var jsonData = jsonEncode(json);
    await localStorage.set("secrets", jsonData);
    return true;
  }
}
