import 'package:fresh_fold_delivery/repository/domain/common/model/name.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_personal_info.dart';

class StringFormatUtils {
  static String mergeNames(EnglishName? englishName) {
    // Check if middle name is provided and construct full name accordingly
    if (englishName?.middleName != "") {
      if (englishName?.lastName != "") {
        return '${englishName?.firstName} ${englishName?.middleName} ${englishName?.lastName}';
      } else {
        return '${englishName?.firstName} ${englishName?.middleName}';
      }
    } else {
      if (englishName?.lastName != "") {
        return '${englishName?.firstName} ${englishName?.lastName}';
      } else {
        return "${englishName?.firstName}";
      }
    }
  }

  static String mergeName(Name? englishName) {
    // Check if middle name is provided and construct full name accordingly
    if (englishName?.middleName != "") {
      if (englishName?.lastName != "") {
        return '${englishName?.firstName} ${englishName?.middleName} ${englishName?.lastName}';
      } else {
        return '${englishName?.firstName} ${englishName?.middleName}';
      }
    } else {
      if (englishName?.lastName != "") {
        return '${englishName?.firstName} ${englishName?.lastName}';
      } else {
        return "${englishName?.firstName}";
      }
    }
  }
}
