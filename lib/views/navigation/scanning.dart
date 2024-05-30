import 'dart:io';

import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key, required this.imageSc, required this.output});
  final File? imageSc;
  final List? output;

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Results'),
      ),
      body: Center(
        child: Column(
          children: [
            Visibility(
                visible: _loading, child: const LinearProgressIndicator()),
            widget.imageSc == null
                ? const Text('Error Try Again')
                : Image.file(
                    widget.imageSc!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 16),
            widget.output != null
                ? Text(
                    "Prediction: ${widget.output![0]['label']}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  )
                : const Text('Not a Rice', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            widget.output![0]['label'].toString() == "Rice Dead Heart"
                ? const Text('Cause of Insect: Stem Borer')
                : widget.output![0]['label'].toString() == "Tungro"
                    ? const Text('Cause of Insect: Green Leafhopper')
                    : const Text('No Insect')
          ],
        ),
      ),
    );
  }
}
