import 'package:flutter/material.dart';
import 'package:general_datetime_picker/src/enums/date_type.dart';
import 'package:general_datetime_picker/src/enums/separator_type.dart';

class ConfigurationModel {
  late DateTypeEnum dateType;
  int? minYear;
  int? maxYear;
  bool? showMonthName;
  bool? looping;
  TextStyle? textStyle;
  SeparatorTypeEnum? separatorType;

  static ConfigurationModel? _instance;

  ConfigurationModel._(this.dateType, this.minYear, this.maxYear,
      this.showMonthName, this.looping, this.textStyle, this.separatorType);

  factory ConfigurationModel(
      {required DateTypeEnum dateType,
      int? minYear,
      int? maxYear,
      bool? showMonthName,
      bool? looping,
      TextStyle? textStyle,
      SeparatorTypeEnum? separatorType,
      }) {
    _instance ??= ConfigurationModel._(
        dateType, minYear, maxYear, showMonthName, looping, textStyle, separatorType);

    return _instance!;
  }

  ConfigurationModel.clone(ConfigurationModel obj) : this._(
    obj.dateType, obj.minYear, obj.maxYear,
      obj.showMonthName, obj.looping, obj.textStyle, obj.separatorType
  );
}
