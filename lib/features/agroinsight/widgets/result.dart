import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String label;
  const ResultPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Insight',
          style: TextStyle(fontFamily: "Poppins"),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: Image.asset(
                    "assets/images/store/corns.png",
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Result',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                )),
                readOnly: true,
                controller: TextEditingController(text: label.split(":")[1]),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
