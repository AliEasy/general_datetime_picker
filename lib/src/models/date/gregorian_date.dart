import 'package:flutter/cupertino.dart';
import 'package:general_datetime_picker/src/base/strings.dart';
import 'package:general_datetime_picker/src/models/date/base_date.dart';

class GregorianDateModel extends BaseDateModel {
  String _getCurrentDateStr() {
    var now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}";
  }

  String _getStrDateFromDateTime(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")}";
  }

  int _getCurrentYear() {
    var now = DateTime.now();
    return now.year;
  }

  @override
  String checkStrDate(String? date) {
    String finalDate = _getCurrentDateStr();
    if ((date ?? '').isEmpty) {
      return finalDate;
    }

    try {
      var split = date!.split('-');
      var y = int.parse(split[0]);
      var m = int.parse(split[1]);
      var d = int.parse(split[2]);
      var dt = DateTime(y, m, d);
      finalDate = _getStrDateFromDateTime(dt);
    } catch (e) {
      debugPrint('$e');
    }

    return finalDate;
  }

  @override
  int extractIntDayFromStrDate(String date) {
    var dt = DateTime.parse(date);
    return dt.day;
  }

  @override
  int extractIntMonthFromStrDate(String date) {
    var dt = DateTime.parse(date);
    return dt.month;
  }

  @override
  int extractIntYearFromStrDate(String date) {
    var dt = DateTime.parse(date);
    return dt.year;
  }

  @override
  String getCurrentDateStr() {
    return _getCurrentDateStr();
  }

  @override
  int getCurrentDay() {
    return DateTime.now().day;
  }

  @override
  int getCurrentMonth() {
    return DateTime.now().month;
  }

  @override
  int getCurrentYear() {
    return DateTime.now().year;
  }

  @override
  List<int> getDaysList(int month, int year) {
    int start = 1;
    late int end;

    if (month == 1) {
      end = 31;
    } else if (month == 2) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      if (isLeapYear) {
        end = 29;
      } else {
        end = 28;
      }
    } else if (month == 3) {
      end = 31;
    } else if (month == 4) {
      end = 30;
    } else if (month == 5) {
      end = 31;
    } else if (month == 6) {
      end = 30;
    } else if (month == 7) {
      end = 31;
    } else if (month == 8) {
      end = 31;
    } else if (month == 9) {
      end = 30;
    } else if (month == 10) {
      end = 31;
    } else if (month == 11) {
      end = 30;
    } else if (month == 12) {
      end = 31;
    }

    List<int> finalList = [];
    for (int i = start; i <= end; i++) {
      finalList.add(i);
    }

    return finalList;
  }

  @override
  List<int> getMonthList() {
    return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  }

  @override
  List<Map<int, String>> getMonthListWithName() {
    return [
      {1: StringsEn.labelJanuary},
      {2: StringsEn.labelFebruary},
      {3: StringsEn.labelMarch},
      {4: StringsEn.labelApril},
      {5: StringsEn.labelMay},
      {6: StringsEn.labelJune},
      {7: StringsEn.labelJuly},
      {8: StringsEn.labelAugust},
      {9: StringsEn.labelSeptember},
      {10: StringsEn.labelOctober},
      {11: StringsEn.labelNovember},
      {12: StringsEn.labelDecember},
    ];
  }

  @override
  List<int> getYearList(
      int? minYear, int? maxYear, int? minYearRange, int? maxYearRange) {
    late int finalMinYear;
    late int finalMaxYear;

    if ((minYear ?? 0) > 0 && (maxYear ?? 0) > 0) {
      finalMinYear = minYear!;
      finalMaxYear = maxYear!;
    } else if ((minYearRange ?? 0) > 0 && (maxYearRange ?? 0) > 0) {
      int currentYear = _getCurrentYear();
      finalMinYear = currentYear - minYearRange!;
      finalMaxYear = currentYear + maxYearRange!;
    } else {
      int currentYear = _getCurrentYear();
      finalMinYear = currentYear - 5;
      finalMaxYear = currentYear + 5;
    }

    List<int> finalList = [];
    for (int i = finalMinYear; i <= finalMaxYear; i++) {
      finalList.add(i);
    }

    return finalList;
  }
}
