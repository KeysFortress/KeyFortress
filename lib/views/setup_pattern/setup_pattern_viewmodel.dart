import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
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
        _filledPattern = input;
        _isConfirm = true;
        notifyListeners();

      case false:
        var matching = false;
        var pos = 0;
        input.forEach((element) {
          matching = _filledPattern.elementAt(pos) == element;
          pos++;
          if (!matching) return;
        });

        if (!matching) return;

        var convertToString = "";

        input.forEach((e) {
          convertToString += "${e},";
        });
        convertToString =
            convertToString.substring(0, convertToString.length - 1);
        var lockCreated = await _authorizationService.setDeviceLockType(
          DeviceLockType.pattern,
          value: convertToString,
        );

        //TODO raise excepotion in case it fails
        if (!lockCreated) return;
        router.router.router.go("/lock");

        break;
    }
  }
}
