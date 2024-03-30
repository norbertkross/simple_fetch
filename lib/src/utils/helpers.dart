import 'package:simple_fetch/src/enums/enums.dart';

class Helpers {

  /// Assert if the response type matches
  static assertIsList(dynamic variable, ResponseTypeChecker checker) {
    if (variable is List && checker != ResponseTypeChecker.list) {
      throw Exception("Use getList for list requests or add a transformer");
    }

    if ((variable is List) == false && checker != ResponseTypeChecker.object) {
      throw Exception("Use get for object requests or add a transformer");
    }
  }
}
