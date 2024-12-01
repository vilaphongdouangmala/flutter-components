import 'package:flutter/services.dart';

class InputUtils {
  static FilteringTextInputFormatter getNumberWithDecimalFormatter() {
    return FilteringTextInputFormatter.allow(
      RegExp(r'^\d+\.?\d{0,2}'),
    );
  }

  static FilteringTextInputFormatter getQuantityFormatter() {
    return FilteringTextInputFormatter.allow(
      RegExp(r'^\d+'),
    );
  }
}
