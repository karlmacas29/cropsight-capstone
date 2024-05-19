import 'dart:io';

import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key, required this.imageSc});
  final File? imageSc;

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Processing'),
      ),
      body: Center(
        child: widget.imageSc == null
            ? Text('No image selected.')
            : Image.file(widget.imageSc!),
      ),
    );
  }
}
