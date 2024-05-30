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
                ? const Text('No image selected.')
                : Image.file(widget.imageSc!),
            const SizedBox(height: 16),
            widget.output != null
                ? Text(
                    "Prediction: ${widget.output![0]['label']}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  )
                : Container(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
