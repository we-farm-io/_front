import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String label;
  const ResultPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Your Result:',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              'https://via.placeholder.com/150', // Placeholder image URL
              width: 150,
              height: 150,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
