import 'package:flutter/cupertino.dart';

class SelectorWidget extends StatefulWidget {
  const SelectorWidget({super.key});

  @override
  State<SelectorWidget> createState() => _SelectorWidgetState();
}

class _SelectorWidgetState extends State<SelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(itemExtent: null,);
  }
}
