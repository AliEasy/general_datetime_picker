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
  final bool? showMonthName;
  final DateTypeEnum dateType;
  final int? minYearRange;
  final int? maxYearRange;
  final TextEditingController? outputController;
  final Function(String output)? outputFunction;
  final bool? looping;
  final TextStyle? textStyle;

  const VerticalDatePicker(
      {super.key,
      this.minYear,
      this.maxYear,
      this.initialDate,
      this.showMonthName,
      this.dateType = DateTypeEnum.gregorian,
      this.minYearRange,
      this.maxYearRange,
      this.outputController,
      this.outputFunction,
      this.looping,
      this.textStyle});

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

    _configuration.showMonthName =
        widget.showMonthName ?? _configuration.showMonthName;
    _configuration.looping = widget.looping ?? _configuration.looping;
    _configuration.textStyle = widget.textStyle ?? _configuration.textStyle;
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
              _makeOutput();
            },
            initialValue: _year,
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
            children: (_configuration.showMonthName ?? false)
                ? dateClass.getMonthListWithName()
                : dateClass.getMonthList(),
            onChangeCallBack: (value) {
              _month = value;
              _makeOutput();
              setState(() {});
            },
            initialValue: _month,
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
            children: dateClass.getDaysList(_month, _year),
            onChangeCallBack: (value) {
              _day = value;
              _makeOutput();
            },
            initialValue: _day,
            looping: _configuration.looping,
            textStyle: _configuration.textStyle,
          ),
        ),
      ],
    );
  }

  _makeOutput() {
    late String separator;
    if (_configuration.dateType == DateTypeEnum.gregorian) {
      separator = '-';
    } else if (_configuration.dateType == DateTypeEnum.jalali) {
      separator = '/';
    }
    String output = '$_year$separator$_month$separator$_day$separator';

    if (widget.outputController != null) {
      widget.outputController!.text = output;
    }
    if (widget.outputFunction != null) {
      widget.outputFunction!(output);
    }
  }
}
