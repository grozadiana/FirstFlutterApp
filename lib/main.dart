import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '';
  String? errorMessage;
  double? convertedValue;

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency converter'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            child: Image.network(
                'https://www.bizbrasov.ro/wp-content/uploads/2023/03/bani.v1-2.jpg'),
          ),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter the amount in EUR',
              errorText: errorMessage,
            ),
            onChanged: (String value) {
              setState(() {
                if (value.isEmpty || !RegExp(r'^[0-9]*$').hasMatch(value)) {
                  errorMessage = 'Enter a number';
                } else {
                  errorMessage = null;
                }
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              double euroValue = double.tryParse(controller.text) ?? 0.0;
              double leiValue = euroValue * 4.9;
              setState(() {
                convertedValue = leiValue;
              });
            },
            child: Text('Convert'),
          ),
          convertedValue != null
              ? Text('Converted Value: $convertedValue Lei')
              : Container(),
        ],
      ),
    );
  }
}
