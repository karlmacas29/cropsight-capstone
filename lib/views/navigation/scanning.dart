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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            Column(
              children: [
                Visibility(
                    visible: _loading, child: const LinearProgressIndicator()),
                widget.imageSc == null
                    ? const Text('Error Try Again')
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          widget.imageSc!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
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
                    ? Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/stemborer/2s.jpg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Stem Borer',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 400,
                            child: const Text(
                              textAlign: TextAlign.justify,
                              'Rice stem borers (RSB) can be present in all rice growing areas. During tillering, the typical damage symptom is deadheart, while in flowering stage, it causes whitehead. The larvae also produce tiny holes on the stem and deposit faeces within it, which is seen when the stem is cut open.',
                            ),
                          ),
                        ],
                      )
                    : widget.output![0]['label'].toString() == "Tungro"
                        ? Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/greenleafhopper/1s.jpg',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    'Green Leafhopper',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 400,
                                child: const Text(
                                  textAlign: TextAlign.justify,
                                  'Adults and nymphs cause direct damage to the rice plant by sucking the sap from leaf sheaths and leaf blades. GLH also cause indirect damage by injecting toxic chemicals and transmitting viruses (tungro, dwarf, transitory yellowing, and yellow- orange leaf) and a mycoplasma disease (yellow dwarf). They mostly confine themselves and feed on the leaf and leaf sheath of rice. Mild infestations reduce plant vigor and number of productive tillers. Heavy infestations cause withering and complete drying of the crop.',
                                ),
                              ),
                            ],
                          )
                        : const Text('No Insect')
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
