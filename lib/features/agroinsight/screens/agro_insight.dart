import 'package:flutter/material.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class AgroInsight extends StatefulWidget {
  const AgroInsight({super.key});

  @override
  State<AgroInsight> createState() => _AgroInsightState();
}

class _AgroInsightState extends State<AgroInsight> {
  late Interpreter _interpreter;
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadModel();
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
              InputField(
                label: 'Field 1',
                controller: controller1,
              ),
              InputField(
                label: 'Field 2',
                controller: controller2,
              ),
              InputField(
                label: 'Field 3',
                controller: controller3,
              ),
              InputField(
                label: 'Field 4',
                controller: controller4,
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  // Handle validate button press
                  _validate(context);
                },
                buttonText: "Validate",
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validate(BuildContext context) {
    List<List<double>> input = [
      [1, 1, 1, 1, 1, 1, 1]
    ];
    int row = 1;
    int col = 22;
    // output of shape [1,2].
    var output = List<List>.generate(row,
        (i) => List<dynamic>.generate(col, (index) => null, growable: false),
        growable: false);

    _interpreter.run(input, output);
    print(output);
    print("should have run");
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
}

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const InputField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Enter $label',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
