import 'package:flutter/cupertino.dart';
import 'package:general_datetime_picker/src/base/strings.dart';
import 'package:general_datetime_picker/src/models/date/base_date.dart';
import 'package:shamsi_date/shamsi_date.dart';

class JalaliDateModel extends BaseDateModel {
  JalaliDateModel();

  String _getCurrentDateStr() {
    Jalali now = Jalali.now();
    var formatter = now.formatter;
    return "${formatter.yyyy}/${formatter.mm}/${formatter.dd}";
  }

  String _getStrDateFromJalali(Jalali date) {
    var formatter = date.formatter;
    return "${formatter.yyyy}/${formatter.mm}/${formatter.dd}";
  }

  int _getCurrentYear() {
    Jalali now = Jalali.now();
    return now.year;
  }

  @override
  List<int> getDaysList(int month, int year) {
    int start = 1;
    late int end;

    if (month < 7) {
      end = 31;
    } else if (month < 11) {
      end = 30;
    } else {
      if (Jalali(year).isLeapYear()) {
        end = 30;
      } else {
        end = 29;
      }
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
      {1: StringsFa.labelFarvardin},
      {2: StringsFa.labelOrdibehesht},
      {3: StringsFa.labelKhordad},
      {4: StringsFa.labelTir},
      {5: StringsFa.labelMordad},
      {6: StringsFa.labelShahrivar},
      {7: StringsFa.labelMehr},
      {8: StringsFa.labelAban},
      {9: StringsFa.labelAzar},
      {10: StringsFa.labelDey},
      {11: StringsFa.labelBahman},
      {12: StringsFa.labelEsfand},
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

  @override
  String getCurrentDateStr() {
    return _getCurrentDateStr();
  }

  @override
  int getCurrentDay() {
    Jalali now = Jalali.now();
    return now.day;
  }

  @override
  int getCurrentMonth() {
    Jalali now = Jalali.now();
    return now.month;
  }

  @override
  int getCurrentYear() {
    Jalali now = Jalali.now();
    return now.year;
  }

  @override
  String checkStrDate(String? date) {
    String finalDate = _getCurrentDateStr();
    if ((date ?? '').isEmpty) {
      return finalDate;
    }

    try {
      var split = date!.split('/');
      var y = int.parse(split[0]);
      var m = int.parse(split[1]);
      var d = int.parse(split[2]);
      var j = Jalali(y, m, d);
      finalDate = _getStrDateFromJalali(j);
    } catch (e) {
      debugPrint('$e');
    }

    return finalDate;
  }

  @override
  int extractIntDayFromStrDate(String date) {
    var split = date.split('/');
    return int.parse(split[2]);
  }

  @override
  int extractIntMonthFromStrDate(String date) {
    var split = date.split('/');
    return int.parse(split[1]);
  }

  @override
  int extractIntYearFromStrDate(String date) {
    var split = date.split('/');
    return int.parse(split[0]);
  }
}
