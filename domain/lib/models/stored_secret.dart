import 'package:domain/models/enums.dart';

class StoredSecret {
  String name;
  String content;
  String username;
  DateTime lastUsed;
  SecretType secretType;

  StoredSecret({
    required this.name,
    required this.username,
    required this.content,
    required this.lastUsed,
    required this.secretType,
  });

  factory StoredSecret.fromJson(Map<String, dynamic> element) {
    return StoredSecret(
      name: element["name"],
      username: element["username"],
      content: element["content"],
      lastUsed: DateTime.parse(element["lastUsed"]),
      secretType:
          element["secret_type"] == 1 ? SecretType.password : SecretType.custom,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'content': content,
      'lastUsed': lastUsed.toIso8601String(),
      'secretType': secretType == SecretType.password ? 1 : 0,
    };
  }
}
