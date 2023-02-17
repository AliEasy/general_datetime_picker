import 'package:general_datetime_picker/src/enums/date_type.dart';

class ConfigurationModel {
  late DateTypeEnum dateType;
  int? minYear;
  int? maxYear;
  bool showMonthName;

  static ConfigurationModel? _instance;

  ConfigurationModel._(
      this.dateType, this.minYear, this.maxYear, this.showMonthName);

  factory ConfigurationModel({
    required DateTypeEnum dateType,
    int? minYear,
    int? maxYear,
    bool showMonthName = false,
  }) {
    _instance ??=
        ConfigurationModel._(dateType, minYear, maxYear, showMonthName);

    return _instance!;
  }
}
