import 'package:fresh_fold_delivery/repository/repository.dart';

extension CalculationModeValue on CalculationMode {
  String get value => getValue();

  String getValue() {
    switch (this) {
      case CalculationMode.viaBase:
        return "1";
      case CalculationMode.viaCounter:
        return "2";
    }
  }
}
