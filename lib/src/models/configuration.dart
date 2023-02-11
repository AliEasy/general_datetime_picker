class ConfigurationModel {
  late String dateType;

  static ConfigurationModel? _instance;

  ConfigurationModel._(this.dateType);

  factory ConfigurationModel({
    required String dateType,
  }) {
    _instance ??= ConfigurationModel._(dateType);
    return _instance!;
  }
}
