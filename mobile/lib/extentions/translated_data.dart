import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/utils/utils.dart';
import 'package:flutter/material.dart';

extension TranslatedFood on Food {
  String translateName(BuildContext context) {
    return name.split("|").elementAtOrNull(isRTL(context) ? 1 : 0) ?? name;
  }
}

extension TranslatedGoal on Goal {
  String translateName(BuildContext context) {
    return name.split("|").elementAtOrNull(isRTL(context) ? 1 : 0) ?? name;
  }

  String translateLongName(BuildContext context) {
    return longName.split("|").elementAtOrNull(isRTL(context) ? 1 : 0) ??
        longName;
  }

  String translateDescription(BuildContext context) {
    return description.split("|").elementAtOrNull(isRTL(context) ? 1 : 0) ??
        description;
  }

  String translateCategory(BuildContext context) {
    return category.split("|").elementAtOrNull(isRTL(context) ? 1 : 0) ??
        category;
  }
}
