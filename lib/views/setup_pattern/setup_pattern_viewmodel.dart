import 'package:domain/models/enums.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:shared/page_view_model.dart';

class SetupPatternViewModel extends PageViewModel {
  late IAuthorizationService _authorizationService;
  bool _isConfirm = false;
  get isConfirm => _isConfirm;
  SetupPatternViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
  }

  List<int> _filledPattern = [];

  onPatternFilled(List<int> input) async {
    switch (_filledPattern.isEmpty) {
      case true:
        var matching = input == _filledPattern;
        if (!matching) return;

        var convertToString = "";

        input.forEach((e) {
          convertToString += "${e},";
        });

        await _authorizationService.setDeviceLockType(
          DeviceLockType.pattern,
          value: convertToString,
        );
      case false:
        _filledPattern = input;
        break;
    }
  }
}
