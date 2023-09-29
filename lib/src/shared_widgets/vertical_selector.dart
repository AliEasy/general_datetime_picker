import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:general_datetime_picker/src/shared_widgets/shared_widgets.dart';

class VerticalSelectorWidget extends StatelessWidget {
  final List<Map<int, String>> children;
  final bool? looping;
  final bool? slightVibrate;
  final Function onChangeCallBack;
  final dynamic initialValue;
  final TextStyle? textStyle;
  final Widget? selectionOverlay;
  const VerticalSelectorWidget(
      {super.key,
      this.looping = false,
      required this.children,
      this.slightVibrate = true,
      required this.onChangeCallBack,
      this.initialValue,
      this.textStyle,
      this.selectionOverlay})
      : assert(children.length > 0);

  @override
  Widget build(BuildContext context) {
    var childrenWidget = _childrenGenerator();

    return CupertinoPicker(
      scrollController:
          FixedExtentScrollController(initialItem: _getInitialValueIndex()),
      itemExtent: 50,
      looping: (looping ?? false),
      onSelectedItemChanged: (value) {
        if ((slightVibrate ?? false)) {
          HapticFeedback.vibrate();
        }

        int returnValue = 0;
        Map<int, String> selected = children.elementAt(value);
        returnValue = selected.keys.first;
        onChangeCallBack(returnValue);
      },
      selectionOverlay:
          selectionOverlay ?? SharedWidgets.defaultSelectionOverlayWidget(),
      children: childrenWidget,
    );
  }

  List<Widget> _childrenGenerator() {
    List<String> finalChildren = [];
    finalChildren.addAll([...children.map((el) => el.values.first)]);

    return List.generate(
        finalChildren.length,
        (index) => Center(
              child: Text(
                finalChildren[index],
                style: textStyle,
              ),
            ));
  }

  int _getInitialValueIndex() {
    int finalResult = 0;
    try {
      finalResult =
          children.indexWhere((element) => element.keys.first == initialValue);
    } catch (e) {
      debugPrint('$e');
    }
    return finalResult;
  }
}
