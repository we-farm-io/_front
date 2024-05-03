// import 'package:flutter/material.dart';
// import 'package:smart_farm/shared/widgets/custom_button.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// class AgroInsight extends StatefulWidget {
//   const AgroInsight({super.key});

//   @override
//   State<AgroInsight> createState() => _AgroInsightState();
// }

// class _AgroInsightState extends State<AgroInsight> {
//   late Interpreter _interpreter;
//   final TextEditingController controller1 = TextEditingController();
//   final TextEditingController controller2 = TextEditingController();
//   final TextEditingController controller3 = TextEditingController();
//   final TextEditingController controller4 = TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loadModel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InputField(
//                 label: 'Field 1',
//                 controller: controller1,
//               ),
//               InputField(
//                 label: 'Field 2',
//                 controller: controller2,
//               ),
//               InputField(
//                 label: 'Field 3',
//                 controller: controller3,
//               ),
//               InputField(
//                 label: 'Field 4',
//                 controller: controller4,
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                 onPressed: () {
//                   // Handle validate button press
//                   _validate(context);
//                 },
//                 buttonText: "Validate",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _validate(BuildContext context) {
//     List<List<double>> input = [
//       [12, 6, 8, 30.84835031, 92.86773675, 6.388617138, 107.4142681]
//     ];
//     int row = 1;
//     int col = 22;
//     // output of shape [1,2].
//     var output = List<List>.generate(row,
//         (i) => List<dynamic>.generate(col, (index) => null, growable: false),
//         growable: false);
//     _interpreter.run(input, output);
//     print(output);
//     print("should have run");
//   }

//   void _loadModel() async {
//     _interpreter =
//         await Interpreter.fromAsset("assets/models/svm_model.tflite");
//     print("interpreter loaded successfully");
//     _interpreter.allocateTensors();
// // Print list of input tensors
//     print(_interpreter.getInputTensors());
// // Print list of output tensors
//     print(_interpreter.getOutputTensors());
//   }
// }

// class InputField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const InputField({super.key, required this.label, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             border: const OutlineInputBorder(),
//             hintText: 'Enter $label',
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgroInsight extends StatefulWidget {
  const AgroInsight({super.key});

  @override
  _AgroInsightState createState() => _AgroInsightState();
}

class _AgroInsightState extends State<AgroInsight> {
  final String apiUrl =
      'https://api.weatherbit.io/v2.0/history/daily?lat=35.2644406&lon=-0.68899378&start_date=2023-1-25&end_date=2023-12-26&key=af606978766f43a7911ff411cbf168e3';

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Averages'),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final dataList = snapshot.data?['data'];

            double totalTemp = 0;
            double totalRH = 0;
            double totalPrecip = 0;

            for (var data in dataList) {
              totalTemp += data['temp'];
              totalRH += data['rh'];
              totalPrecip += data['precip'];
            }

            double avgTemp = totalTemp / dataList.length;
            int avgRH = (totalRH / dataList.length).round();
            double avgPrecip = totalPrecip;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Average Temperature: ${avgTemp.toStringAsFixed(1)}°C',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Average Relative Humidity: $avgRH%',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Average Precipitation: ${avgPrecip.toStringAsFixed(1)} mm',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
