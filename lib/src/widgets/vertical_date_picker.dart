import 'package:flutter/material.dart';
import 'package:general_datetime_picker/src/enums/date_type.dart';
import 'package:general_datetime_picker/src/models/date/base_date.dart';
import 'package:general_datetime_picker/src/models/date/gregorian_date.dart';
import 'package:general_datetime_picker/src/models/configuration.dart';
import 'package:general_datetime_picker/src/models/date/jalali_date.dart';
import 'package:general_datetime_picker/src/shared_widgets/vertical_selector.dart';

class VerticalDatePicker extends StatefulWidget {
  final int? minYear;
  final int? maxYear;
  final String? initialDate;
  final bool showMonthName;
  final DateTypeEnum dateType;
  final int? minYearRange;
  final int? maxYearRange;

  const VerticalDatePicker(
      {super.key,
      this.minYear,
      this.maxYear,
      this.initialDate,
      this.showMonthName = false,
      this.dateType = DateTypeEnum.gregorian,
      this.minYearRange,
      this.maxYearRange});

  @override
  State<VerticalDatePicker> createState() => _VerticalDatePickerState();
}

class _VerticalDatePickerState extends State<VerticalDatePicker> {
  late BaseDateModel dateClass;
  late int _year;
  late int _month;
  late int _day;
  late ConfigurationModel _configuration;

  @override
  void initState() {
    _initializer();
    super.initState();
  }

  _initializer() {
    _configuration = ConfigurationModel(dateType: widget.dateType);

    if (_configuration.dateType == DateTypeEnum.gregorian) {
      dateClass = GregorianDateModel();
    } else if (_configuration.dateType == DateTypeEnum.jalali) {
      dateClass = JalaliDateModel();
    }

    String initialDate = dateClass.checkStrDate(widget.initialDate);

    _year = dateClass.extractIntYearFromStrDate(initialDate);
    _month = dateClass.extractIntMonthFromStrDate(initialDate);
    _day = dateClass.extractIntDayFromStrDate(initialDate);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: VerticalSelectorWidget(
            children: dateClass.getYearList(widget.minYear, widget.maxYear,
                widget.minYearRange, widget.maxYearRange),
            onChangeCallBack: (value) {
              _year = value;
            },
            initialValue: _year,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 1,
          child: VerticalSelectorWidget(
            children: widget.showMonthName
                ? dateClass.getMonthListWithName()
                : dateClass.getMonthList(),
            onChangeCallBack: (value) {
              _month = value;
            },
            initialValue: _month,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 1,
          child: VerticalSelectorWidget(
            children: dateClass.getDaysList(_month, _year),
            onChangeCallBack: (value) {
              _day = value;
            },
            initialValue: _day,
          ),
        ),
      ],
    );
  }
}
