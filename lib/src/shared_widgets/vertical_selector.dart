import 'package:flutter/cupertino.dart';
import 'package:general_datetime_picker/src/shared_widgets/shared_widgets.dart';

class VerticalSelectorWidget extends StatefulWidget {
  final List<Map<int, String>> children;
  final int initialValue;
  final Function onChangeCallBack;
  final bool? looping;
  final TextStyle? textStyle;
  final Widget? selectionOverlay;
  const VerticalSelectorWidget(
      {super.key,
      required this.children,
      required this.onChangeCallBack,
      required this.initialValue,
      this.looping = false,
      this.textStyle,
      this.selectionOverlay})
      : assert(children.length > 0);

  @override
  State<VerticalSelectorWidget> createState() => VerticalSelectorWidgetState();
}

class VerticalSelectorWidgetState extends State<VerticalSelectorWidget> {
  late FixedExtentScrollController _scrollController;
  late List<Widget> _childrenWidget;

  @override
  void initState() {
    _scrollController =
        FixedExtentScrollController(initialItem: _getInitialValueIndex());
    _childrenWidget = _childrenGenerator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: _scrollController,
      itemExtent: 50,
      looping: (widget.looping ?? false),
      onSelectedItemChanged: (value) {
        int returnValue = 0;
        Map<int, String> selected = widget.children.elementAt(value);
        returnValue = selected.keys.first;
        widget.onChangeCallBack(returnValue);
      },
      selectionOverlay: widget.selectionOverlay ??
          SharedWidgets.defaultSelectionOverlayWidget(),
      children: _childrenWidget,
    );
  }

  List<Widget> _childrenGenerator() {
    List<String> finalChildren = [];
    finalChildren.addAll([...widget.children.map((el) => el.values.first)]);

    return List.generate(
        finalChildren.length,
        (index) => Center(
              child: Text(
                finalChildren[index],
                style: widget.textStyle,
              ),
            ));
  }

  int _getInitialValueIndex() {
    int finalResult = 0;
    try {
      finalResult = widget.children
          .indexWhere((element) => element.keys.first == widget.initialValue);
    } catch (e, st) {
      debugPrint('$e | $st');
    }
    return finalResult;
  }

  int _getChildIndex(int child) {
    int finalResult = 0;
    try {
      finalResult =
          widget.children.indexWhere((element) => element.keys.first == child);
    } catch (e, st) {
      debugPrint('$e | $st');
    }
    return finalResult;
  }

  void scrollToChild(int child) {
    int destIndex = _getChildIndex(child);
    _scrollController.animateToItem(destIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void scrollToInitial() {
    int destIndex = _getInitialValueIndex();
    _scrollController.animateToItem(destIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
