import 'package:general_datetime_picker/src/enums/date_type.dart';

class ConfigurationModel {
  late DateTypeEnum dateType;
  int? minYear;
  int? maxYear;
  bool? showMonthName;
  bool? looping;

  static ConfigurationModel? _instance;

  ConfigurationModel._(this.dateType, this.minYear, this.maxYear,
      this.showMonthName, this.looping);

  factory ConfigurationModel({
    required DateTypeEnum dateType,
    int? minYear,
    int? maxYear,
    bool? showMonthName,
    bool? looping,
  }) {
    _instance ??= ConfigurationModel._(
        dateType, minYear, maxYear, showMonthName, looping);

    return _instance!;
  }
}
