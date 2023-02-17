class ConfigurationModel {
  late String dateType;
  int? minYear;
  int? maxYear;
  bool showMonthName;

  static ConfigurationModel? _instance;

  ConfigurationModel._(
      this.dateType, this.minYear, this.maxYear, this.showMonthName);

  factory ConfigurationModel({
    required String dateType,
    int? minYear,
    int? maxYear,
    bool showMonthName = false,
  }) {
    _instance ??=
        ConfigurationModel._(dateType, minYear, maxYear, showMonthName);

    return _instance!;
  }
}
