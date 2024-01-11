import 'dart:convert';

import 'package:domain/models/signature_event.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/isignature_store.dart';

class SignatureStore implements ISignatureStore {
  late IlocalStorage _storage;

  SignatureStore(this._storage);

  @override
  Future<List<SignatureEvent>> get() async {
    var existing = await _storage.get("stored_signatre_events");

    if (existing == null) {
      return [];
    }

    List<Map<String, dynamic>> signatures = jsonDecode(existing);
    return signatures.map((e) {
      return SignatureEvent.fromJson(e);
    }).toList();
  }

  @override
  add(SignatureEvent event) async {
    var existing = await _storage.get("stored_signatre_events");

    if (existing == null) {
      List<SignatureEvent> sig = [event];

      var json = sig.map((e) => e.toJson()).toList();

      _storage.set("stored_signatre_events", jsonEncode(json));
      return;
    }

    List<Map<String, dynamic>> signatures = jsonDecode(existing);
    var sigs = signatures.map((e) {
      return SignatureEvent.fromJson(e);
    }).toList();

    sigs.add(event);
    var json = sigs.map((e) => e.toJson()).toList();

    _storage.set("stored_signatre_events", jsonEncode(json));
  }

  @override
  remove(SignatureEvent event) async {
    var existing = await _storage.get("stored_signatre_events");

    if (existing == null) {
      return;
    }
    List<Map<String, dynamic>> signatures = jsonDecode(existing);
    var sigs = signatures.map((e) {
      return SignatureEvent.fromJson(e);
    }).toList();

    sigs.removeWhere((element) => element.signature == event.signature);
    var json = sigs.map((e) => e.toJson()).toList();

    _storage.set("stored_signatre_events", jsonEncode(json));
  }
}
