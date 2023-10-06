import 'package:flutter/material.dart';
import 'package:general_datetime_picker/src/enums/date_type.dart';
import 'package:general_datetime_picker/src/enums/month_viewer_type.dart';
import 'package:general_datetime_picker/src/enums/separator_type.dart';

class ConfigurationModel {
  late DateTypeEnum dateType;
  int? minYear;
  int? maxYear;
  int? minYearRange;
  int? maxYearRange;
  bool? looping;
  TextStyle? textStyle;
  SeparatorTypeEnum? separatorType;
  MonthViewTypeEnum? monthViewType;

  static ConfigurationModel? _instance;

  ConfigurationModel._(this.dateType, this.minYear, this.maxYear, this.looping,
      this.textStyle, this.separatorType, this.monthViewType);

  factory ConfigurationModel({
    required DateTypeEnum dateType,
    int? minYear,
    int? maxYear,
    bool? looping,
    TextStyle? textStyle,
    SeparatorTypeEnum? separatorType,
    MonthViewTypeEnum? monthViewType,
  }) {
    _instance ??= ConfigurationModel._(dateType, minYear, maxYear, looping,
        textStyle, separatorType, monthViewType);

    return _instance!;
  }

  ConfigurationModel.clone(ConfigurationModel obj)
      : this._(obj.dateType, obj.minYear, obj.maxYear, obj.looping,
            obj.textStyle, obj.separatorType, obj.monthViewType);
}
