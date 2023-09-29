abstract class BaseDateModel {
  BaseDateModel();

  List<int> getYearList(
      int? minYear, int? maxYear, int? minYearRange, int? maxYearRange);

  List<int> getMonthList();

  List<Map<int, String>> getMonthListWithName();

  List<String> getMonthNameList();

  List<int> getDaysList(int month, int year);

  String getCurrentDateStr();

  int getCurrentDay();

  int getCurrentYear();

  int getCurrentMonth();

  String checkStrDate(String? date);

  int extractIntYearFromStrDate(String date);

  int extractIntMonthFromStrDate(String date);

  int extractIntDayFromStrDate(String date);
}
