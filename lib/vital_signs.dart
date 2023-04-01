import 'package:flutter/cupertino.dart';

class Signs {

   Map<String, Map<String, Map<String, num>>> signs = {
    "baby": {
      "Temp": {"min": 0, "max": 70, "normal min": 35.5, "normal max": 36.5},
      "HR": {"min": 0, "max": 260, "normal min": 60, "normal max": 130},
      "SPO2": {"min": 0, "max": 200, "normal min": 95, "normal max": 100},
      "BP_Max": {"min": 0, "max": 240, "normal min": 90, "normal max": 120},
      "BP_Min": {"min": 0, "max": 160, "normal min": 50, "normal max": 80},
    },

    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    "child": {
      "Temp": {"min": 0, "max": 70, "normal min": 36, "normal max": 37.3},
      "HR": {"min": 0, "max": 260, "normal min": 60, "normal max": 130},
      "SPO2": {"min": 0, "max": 200, "normal min": 95, "normal max": 100},
      "BP_Max": {"min": 0, "max": 240, "normal min": 90, "normal max": 120},
      "BP_Min": {"min": 0, "max": 160, "normal min": 50, "normal max": 80},
    },

    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    "adult": {
      "Temp": {"min": 0, "max": 70, "normal min": 36.5, "normal max": 37.5},
      "HR": {"min": 0, "max": 180, "normal min": 60, "normal max": 100},
      "SPO2": {"min": 0, "max": 200, "normal min": 95, "normal max": 100},
      "BP_Max": {"min": 0, "max": 270, "normal min": 120, "normal max": 140},
      "BP_Min": {"min": 0, "max": 150, "normal min": 60, "normal max": 90},
    },
  };

  Map<String, Map<String, num>>? getCategory(int age) {
    if (age > 0 && age < 2) {
      return signs["baby"];
    } else if (age > 2 && age <= 13) {
      return signs["child"];
    } else {
      return signs["adult"];
    }
  }
}
