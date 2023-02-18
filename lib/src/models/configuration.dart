import 'package:flutter/material.dart';
import 'package:general_datetime_picker/src/enums/date_type.dart';

class ConfigurationModel {
  late DateTypeEnum dateType;
  int? minYear;
  int? maxYear;
  bool? showMonthName;
  bool? looping;
  TextStyle? textStyle;

  static ConfigurationModel? _instance;

  ConfigurationModel._(this.dateType, this.minYear, this.maxYear,
      this.showMonthName, this.looping, this.textStyle);

  factory ConfigurationModel(
      {required DateTypeEnum dateType,
      int? minYear,
      int? maxYear,
      bool? showMonthName,
      bool? looping,
      TextStyle? textStyle}) {
    _instance ??= ConfigurationModel._(
        dateType, minYear, maxYear, showMonthName, looping, textStyle);

    return _instance!;
  }
}
