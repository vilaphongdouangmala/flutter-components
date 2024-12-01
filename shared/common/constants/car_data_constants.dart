import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:monthol_mobile/shared/models/car_data_model.dart';

class CarDataConstants {
  static List<CarDataColorModel> colors = [
    CarDataColorModel(color: const Color(0xFF8C1616), value: 'maroon'),
    CarDataColorModel(color: const Color(0xFFD9D9D9), value: 'white'),
    CarDataColorModel(color: const Color(0xFF000000), value: 'black'),
    CarDataColorModel(color: const Color(0xFFDE4848), value: 'red'),
    CarDataColorModel(color: const Color(0xFF8E98A8), value: 'silver'),
    CarDataColorModel(color: const Color(0xFFFDDD6B), value: 'yellow'),
    CarDataColorModel(color: const Color(0xFF645948), value: 'brown'),
    CarDataColorModel(color: const Color(0xFF947A5B), value: 'gold'),
    CarDataColorModel(color: const Color(0xFF073F68), value: 'blue'),
    CarDataColorModel(color: const Color(0xFF375914), value: 'green'),
  ];

  static CarDataColorModel? getColorByValue(String value) {
    return colors.firstWhereOrNull((element) => element.value == value);
  }
}
