import 'package:flutter/services.dart';
import 'package:presentation/page_view_model.dart';

class SecretContainerViewModel extends PageViewModel {
  SecretContainerViewModel(super.context);

  onCopyValue(String value) {
    Clipboard.setData(
      ClipboardData(
        text: value,
      ),
    );
  }
}
