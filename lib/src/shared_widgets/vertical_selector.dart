import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class VerticalSelectorWidget extends StatelessWidget {
  final List<dynamic> children;
  final bool looping;
  final bool slightVibrate;
  final Function onChangeCallBack;
  final dynamic initialValue;
  final TextStyle? textStyle;
  const VerticalSelectorWidget(
      {super.key,
      this.looping = false,
      required this.children,
      this.slightVibrate = true,
      required this.onChangeCallBack,
      this.initialValue,
      this.textStyle})
      : assert(children.length > 0);

  @override
  Widget build(BuildContext context) {
    var childrenWidget = _childrenGenerator();

    return CupertinoPicker(
      scrollController:
          FixedExtentScrollController(initialItem: _getInitialValueIndex()),
      itemExtent: 50,
      looping: looping,
      onSelectedItemChanged: (value) {
        if (slightVibrate) {
          HapticFeedback.vibrate();
        }

        int returnValue = 0;
        if (children is List<Map<int, String>>) {
          Map<int, String> selected = children.elementAt(value);
          returnValue = selected.keys.first;
        } else {
          returnValue = children.elementAt(value);
        }
        onChangeCallBack(returnValue);
      },
      children: childrenWidget,
    );
  }

  // List<Widget> _childrenGenerator() {
  //   List<Widget> childrenWidget = [];
  //   if (children is List<Map<int, String>>) {
  //     childrenWidget.addAll(List.generate(
  //         children.length,
  //         (index) => Center(
  //               child: Text(
  //                   '${(children as List<Map<int, String>>)[index].keys.first} / ${(children as List<Map<int, String>>)[index].values.first}'),
  //             )));
  //   } else {
  //     childrenWidget.addAll(List.generate(
  //         children.length,
  //         (index) => Center(
  //               child: Text(children[index].toString(),),
  //             )));
  //   }
  //   return childrenWidget;
  // }

  List<Widget> _childrenGenerator() {
    List<String> finalChildren = [];
    if (children is List<Map<int, String>>) {
      //'${(children as List<Map<int, String>>)[index].keys.first} / ${(children as List<Map<int, String>>)[index].values.first}'
      finalChildren.addAll(
          [...children.map((el) => '${el.keys.first} / ${el.values.first}')]);
    } else if (children is List<int>) {
      finalChildren.addAll([...children.map((el) => el.toString())]);
    }

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
      if (children is List<Map<int, String>>) {
        finalResult = (children as List<Map<int, String>>)
            .indexWhere((element) => element.keys.first == initialValue);
      } else {
        finalResult = children.indexOf(initialValue);
      }
    } catch (e) {
      debugPrint('$e');
    }
    return finalResult;
  }
}
