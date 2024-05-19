import 'package:cropsight/services/management.dart';
import 'package:cropsight/views/descript/manDesc.dart';
import 'package:flutter/material.dart';

class SolutionTab extends StatefulWidget {
  const SolutionTab({super.key});

  @override
  State<SolutionTab> createState() => _SolutionTabState();
}

List<Management> mg = [
  Management(
      inPic1:
          'http://www.knowledgebank.irri.org/images/stories/factsheet-green-leafhopper-1.jpg',
      inName1: 'Green LeafHopper',
      inMan: 'Intest'),
  Management(
      inPic1:
          'http://www.knowledgebank.irri.org/images/stories/leaf-folder-moth.jpg',
      inName1: 'Rice Leaffolder',
      inMan: 'Intest'),
  Management(
      inPic1:
          'http://www.knowledgebank.irri.org/images/stories/factsheet-ricebug-2.jpg',
      inName1: 'Rice Bug',
      inMan: 'Intest'),
  Management(
      inPic1: 'http://www.knowledgebank.irri.org/images/stories/stem-borer.jpg',
      inName1: 'Stem Borer',
      inMan: 'Intest'),
];

class _SolutionTabState extends State<SolutionTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'For Pests',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: mg.length,
            itemBuilder: (ctx, i) {
              return InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageDesc(
                            img: mg[i].inPic1,
                            name: mg[i].inName1,
                            desc: mg[i].inMan),
                      ));
                },
                child: Ink(
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.network(
                                mg[i].inPic1,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            )),
                        Text(
                          mg[i].inName1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 200,
            ),
          ),
        ],
      ),
    );
  }
}
