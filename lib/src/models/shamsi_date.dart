import 'package:flutter/cupertino.dart';
import 'package:general_datetime_picker/src/models/base_date.dart';
import 'package:general_datetime_picker/src/base/strings';
import 'package:shamsi_date/shamsi_date.dart';

class ShamsiDateModel extends BaseDateModel {
  ShamsiDateModel();

  String _getCurrentDateStr() {
    Jalali now = Jalali.now();
    var formatter = now.formatter;
    return "${formatter.yyyy}/${formatter.mm}/${formatter.dd}";
  }

  String _getStrDateFromJalali(Jalali date) {
    var formatter = date.formatter;
    return "${formatter.yyyy}/${formatter.mm}/${formatter.dd}";
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
      {1: StringsFa.farvardin},
      {2: StringsFa.ordibehesht},
      {3: StringsFa.khordad},
      {4: StringsFa.tir},
      {5: StringsFa.mordad},
      {6: StringsFa.shahrivar},
      {7: StringsFa.mehr},
      {8: StringsFa.aban},
      {9: StringsFa.azar},
      {10: StringsFa.dey},
      {11: StringsFa.bahman},
      {12: StringsFa.esfand},
    ];
  }

  @override
  List<int> getYearList(int? minYear, int? maxYear) {
    minYear ??= 1395;
    maxYear ??= 1405;

    List<int> finalList = [];
    for (int i = minYear; i <= maxYear; i++) {
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
