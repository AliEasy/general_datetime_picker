import 'package:flutter/material.dart';
import 'package:general_datetime_picker/src/enums/date_type.dart';
import 'package:general_datetime_picker/src/enums/month_viewer_type.dart';
import 'package:general_datetime_picker/src/enums/separator_type.dart';
import 'package:general_datetime_picker/src/models/date/base_date.dart';
import 'package:general_datetime_picker/src/models/date/gregorian_date.dart';
import 'package:general_datetime_picker/src/models/configuration.dart';
import 'package:general_datetime_picker/src/models/date/jalali_date.dart';
import 'package:general_datetime_picker/src/shared_widgets/vertical_selector.dart';

class VerticalDatePicker extends StatefulWidget {
  final int? minYear;
  final int? maxYear;
  final String? initialDate;
  final DateTypeEnum dateType;
  final int? minYearRange;
  final int? maxYearRange;
  final TextEditingController? outputController;
  final Function(String output)? outputFunction;
  final bool? looping;
  final TextStyle? textStyle;
  final SeparatorTypeEnum? separatorType;
  final MonthViewTypeEnum? monthViewType;

  const VerticalDatePicker({
    super.key,
    this.minYear,
    this.maxYear,
    this.initialDate,
    this.dateType = DateTypeEnum.gregorian,
    this.minYearRange,
    this.maxYearRange,
    this.outputController,
    this.outputFunction,
    this.looping,
    this.textStyle,
    this.separatorType = SeparatorTypeEnum.slash,
    this.monthViewType = MonthViewTypeEnum.name,
  });

  @override
  State<VerticalDatePicker> createState() => _VerticalDatePickerState();
}

class _VerticalDatePickerState extends State<VerticalDatePicker> {
  late BaseDateModel _dateClass;
  late ConfigurationModel _configuration;
  late int _selectedYear;
  late int _selectedMonth;
  late int _selectedDay;
  late List<Map<int, String>> _yearList;
  late List<Map<int, String>> _monthList;
  late List<Map<int, String>> _dayList;

  @override
  void initState() {
    _initializeWidget();
    super.initState();
  }

  void _initializeWidget() {
    _initializeConfiguration();
    _initializeSelectedDate();
    _initializeYearSelector();
    _initializeMonthSelector();
    _initializeDaySelector();
  }

  void _initializeConfiguration() {
    var mainConfiguration = ConfigurationModel(dateType: widget.dateType);
    _configuration = ConfigurationModel.clone(mainConfiguration);

    _configuration.looping = widget.looping ?? _configuration.looping;
    _configuration.textStyle = widget.textStyle ?? _configuration.textStyle;
    _configuration.separatorType =
        widget.separatorType ?? _configuration.separatorType;
    _configuration.monthViewType =
        widget.monthViewType ?? _configuration.monthViewType;
    _configuration.minYear = widget.minYear ?? _configuration.minYear;
    _configuration.maxYear = widget.maxYear ?? _configuration.maxYear;
  }

  void _initializeSelectedDate() {
    if (_configuration.dateType == DateTypeEnum.gregorian) {
      _dateClass = GregorianDateModel();
    } else if (_configuration.dateType == DateTypeEnum.jalali) {
      _dateClass = JalaliDateModel();
    }

    String initialDate = _dateClass.checkStrDate(widget.initialDate);

    _selectedYear = _dateClass.extractIntYearFromStrDate(initialDate);
    _selectedMonth = _dateClass.extractIntMonthFromStrDate(initialDate);
    _selectedDay = _dateClass.extractIntDayFromStrDate(initialDate);
  }

  void _initializeYearSelector() {
    var yearList = _dateClass.getYearList(_configuration.minYear, _configuration.maxYear,
        _configuration.minYearRange, _configuration.maxYearRange);

    _yearList = yearList.map((intElement) {
      return {intElement: intElement.toString()};
    }).toList();
  }

  void _initializeMonthSelector() {
    var monthList = _dateClass.getMonthListWithName();

    if (widget.monthViewType == MonthViewTypeEnum.name) {
      _monthList = monthList.map((element) {
        return {element.keys.first: element.values.first};
      }).toList();
    } else if (widget.monthViewType == MonthViewTypeEnum.number) {
      _monthList = monthList.map((element) {
        return {element.keys.first: element.keys.first.toString()};
      }).toList();
    } else if (widget.monthViewType == MonthViewTypeEnum.numberWithName) {
      _monthList = monthList.map((element) {
        return {
          element.keys.first: '${element.keys.first} / ${element.values.first}'
        };
      }).toList();
    }
  }

  void _initializeDaySelector() {
    var dayList = _dateClass.getDaysList(_selectedMonth, _selectedYear);

    _dayList = dayList.map((intElement) {
      return {intElement: intElement.toString()};
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: VerticalSelectorWidget(
            children: _yearList,
            onChangeCallBack: (value) {
              _selectedYear = value;
              _makeOutput();
            },
            initialValue: _selectedYear,
            looping: _configuration.looping,
            textStyle: _configuration.textStyle,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 1,
          child: VerticalSelectorWidget(
            children: _monthList,
            onChangeCallBack: (value) {
              _selectedMonth = value;
              _makeOutput();
              setState(() {});
            },
            initialValue: _selectedMonth,
            looping: _configuration.looping,
            textStyle: _configuration.textStyle,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 1,
          child: VerticalSelectorWidget(
            children: _dayList,
            onChangeCallBack: (value) {
              _selectedDay = value;
              _makeOutput();
            },
            initialValue: _selectedDay,
            looping: _configuration.looping,
            textStyle: _configuration.textStyle,
          ),
        ),
      ],
    );
  }

  void _makeOutput() {
    late String separator;
    if (_configuration.separatorType == SeparatorTypeEnum.dash) {
      separator = '-';
    } else if (_configuration.separatorType == SeparatorTypeEnum.slash) {
      separator = '/';
    } else if (_configuration.separatorType == SeparatorTypeEnum.none) {
      separator = '';
    }
    String output =
        '$_selectedYear$separator$_selectedMonth$separator$_selectedDay';

    if (widget.outputController != null) {
      widget.outputController!.text = output;
    }
    if (widget.outputFunction != null) {
      widget.outputFunction!(output);
    }
  }
}
