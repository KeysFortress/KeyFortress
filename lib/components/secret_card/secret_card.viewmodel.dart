import 'package:domain/models/stored_secret.dart';
import 'package:flutter/services.dart';
import 'package:presentation/page_view_model.dart';

class SecretCardViewModel extends PageViewModel {
  StoredSecret storedSecret;
  SecretCardViewModel(super.context, this.storedSecret);

  onCopyPressed() {
    Clipboard.setData(
      ClipboardData(
        text: storedSecret.content,
      ),
    );
  }
}
