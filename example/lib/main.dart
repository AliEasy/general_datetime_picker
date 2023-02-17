import 'package:flutter/material.dart';
import 'package:general_datetime_picker/general_datetime_picker.dart';

void main() {
  runApp(const MyApp());

  ConfigurationModel(dateType: DateTypeEnum.jalali, showMonthName: false);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: const [
            VerticalDatePicker(
              showMonthName: true,
            ),
            VerticalDatePicker(),
          ],
        ),
      ),
    );
  }
}
