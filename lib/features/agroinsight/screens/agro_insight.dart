// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:smart_farm/features/agroinsight/widgets/result.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class AgroInsight extends StatefulWidget {
  const AgroInsight({super.key});

  @override
  State<AgroInsight> createState() => _AgroInsightState();
}

class _AgroInsightState extends State<AgroInsight> {
  final String apiUrl =
      'https://api.weatherbit.io/v2.0/history/daily?lat=35.2644406&lon=-0.68899378&start_date=2023-1-25&end_date=2023-1-26&key=af606978766f43a7911ff411cbf168e3';
  late Future<Map<String, dynamic>> futureData;
  String? errorMessage1;
  String? errorMessage2;
  String? errorMessage3;
  String? errorMessage4;
  late Interpreter _interpreter;
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();

    _loadModel();
    if (errorMessage1 == null ||
        errorMessage2 == null ||
        errorMessage3 == null ||
        errorMessage4 == null) {
      futureData = fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Nitrogen Value',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: controller1,
                        onChanged: (value) {
                          setState(() {
                            errorMessage1 =
                                value.isEmpty ? 'Field is required' : null;
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorText: errorMessage1,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Phosphorus value',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: controller2,
                        onChanged: (value) {
                          setState(() {
                            errorMessage2 =
                                value.isEmpty ? 'Field is required' : null;
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorText: errorMessage2,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Potassium Value',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: controller3,
                        onChanged: (value) {
                          setState(() {
                            errorMessage3 =
                                value.isEmpty ? 'Field is required' : null;
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorText: errorMessage3,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'PH value',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: controller4,
                        onChanged: (value) {
                          setState(() {
                            errorMessage4 =
                                value.isEmpty ? 'Field is required' : null;
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorText: errorMessage4,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      final snapshot = await futureData;
                      final dataList = snapshot['data'];

                      double totalTemp = 0;
                      double totalRH = 0;
                      double totalPrecip = 0;

                      for (var data in dataList) {
                        totalTemp += data['temp'];
                        totalRH += data['rh'];
                        totalPrecip += data['precip'];
                      }

                      double avgTemp = totalTemp / dataList.length;
                      double avgRH = (totalRH / dataList.length);
                      double avgPrecip = totalPrecip;
                      // ignore: use_build_context_synchronously
                      int index = _validate(context, avgTemp, avgRH, avgPrecip);
                      if (index != -1) {
                        String labels = await rootBundle
                            .loadString("assets/models/labels_2.txt");
                        List<String> labelslist = labels.split('\n');
                        print(labelslist[index]);
                        navigator.push(
                          MaterialPageRoute(
                            builder: (context) => ResultPage(
                              label: labelslist[index],
                            ),
                          ),
                        );
                      }
                    },
                    buttonText: "Predict",
                  ),
                ],
              ),
            )));
  }

  List<List<double>> preprocessInput(List<List<double>> input) {
    // Mean and standard deviation values
    List<double> mean = [
      50.49375,
      53.54772727,
      47.59943182,
      25.68536435,
      71.23433427,
      6.46459574,
      103.57447831
    ];
    List<double> std = [
      36.84445138,
      32.6025305,
      50.09864473,
      5.04420422,
      22.30561638,
      0.77028467,
      55.10676145
    ];

    // Preprocessed input list
    List<List<double>> preprocessedInput = [];

    for (List<double> data in input) {
      List<double> newData = [];
      for (int i = 0; i < data.length; i++) {
        // Applying the formula
        double newValue = (data[i] - mean[i]) / std[i];
        newData.add(newValue);
      }
      preprocessedInput.add(newData);
    }

    return preprocessedInput;
  }

  int _validate(BuildContext context, double temperature, double humidity,
      double precipitation) {
    // Get values from text controllers

    setState(() {
      errorMessage1 = controller1.text.isEmpty ? 'Field is required' : null;
      errorMessage2 = controller2.text.isEmpty ? 'Field is required' : null;
      errorMessage3 = controller3.text.isEmpty ? 'Field is required' : null;
      errorMessage4 = controller4.text.isEmpty ? 'Field is required' : null;
    });

    double nValue = double.tryParse(controller1.text) ?? 0.0;
    double pValue = double.tryParse(controller2.text) ?? 0.0;
    double kValue = double.tryParse(controller3.text) ?? 0.0;
    double phValue = double.tryParse(controller4.text) ?? 0.0;

    // Validate if any field is empty
    if (nValue == 0.0 || pValue == 0.0 || kValue == 0.0 || phValue == 0.0) {
      return -1;
    }

    // Preprocess input for inference
    List<List<double>> input = [
      [nValue, pValue, kValue, temperature, humidity, phValue, precipitation]
    ];
    input = preprocessInput(input);

    // Perform inference
    int row = 1;
    int col = 22;
    var output = List<List>.generate(row,
        (i) => List<dynamic>.generate(col, (index) => null, growable: false),
        growable: false);
    _interpreter.run(input, output);
    int? maxindex = findMaxIndex(output);
    if (maxindex == null) {}
    print(maxindex);
    print("should have run");
    return maxindex ?? 0;
  }

  void _loadModel() async {
    _interpreter =
        await Interpreter.fromAsset("assets/models/svm_model.tflite");
    print("interpreter loaded successfully");
    _interpreter.allocateTensors();
    // Print list of input tensors
    print(_interpreter.getInputTensors());
    // Print list of output tensors
    print(_interpreter.getOutputTensors());
  }

  int? findMaxIndex(List<List<dynamic>> array) {
    double maxValue = double.negativeInfinity;
    int? maxIndex;

    for (int i = 0; i < array[0].length; i++) {
      if (array[0][i] > maxValue) {
        maxValue = array[0][i];
        maxIndex = i;
      }
    }

    return maxIndex;
  }
}
