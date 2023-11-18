import 'package:flutter/material.dart';
import 'package:general_datetime_picker/general_datetime_picker.dart';

void main() {
  runApp(const MyApp());

  ConfigurationModel(
    dateType: DateTypeEnum.jalali,
    separatorType: SeparatorTypeEnum.slash,
    monthViewType: MonthViewTypeEnum.name,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  final _key = GlobalKey<VerticalDatePickerState>();
  final _key1 = GlobalKey<VerticalDatePickerState>();

  @override
  void initState() {
    _controller.addListener(() {
      debugPrint(_controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // VerticalDatePicker(
            //   outputFunction: (output) {
            //     debugPrint(output);
            //   },
            // ),
            // const SizedBox(
            //   height: 50,
            // ),
            // VerticalDatePicker(
            //   key: _key,
            //   outputController: _controller,
            //   looping: true,
            //   separatorType: SeparatorTypeEnum.dash,
            //   monthViewType: MonthViewTypeEnum.numberWithName,
            // ),
            // const SizedBox(
            //   height: 50,
            // ),
             VerticalDatePicker(
              key: _key1,
              outputController: _controller,
              looping: true,
              separatorType: SeparatorTypeEnum.dash,
              monthViewType: MonthViewTypeEnum.numberWithName,
              dateType: DateTypeEnum.gregorian,
              initialDate: '2023-11-16',
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  _key.currentState?.goToCurrentDate();
                  _key1.currentState?.goToCurrentDate();
                },
                child: Text('CurrentDate')),
                ElevatedButton(
                onPressed: () {
                  _key.currentState?.goToInitialDate();
                  _key1.currentState?.goToInitialDate();
                },
                child: Text('InitialDate')),
          ],
        ),
      ),
    );
  }
}
