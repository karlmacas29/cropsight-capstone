import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage(
      {super.key,
      required this.name,
      required this.image,
      required this.desc,
      required this.inWhere,
      required this.inDamage});
  final String name, image, desc, inWhere, inDamage;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color.fromRGBO(244, 253, 255, 1)
          : const Color.fromRGBO(18, 18, 18, 1),
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? const Color.fromRGBO(244, 253, 255, 1)
            : const Color.fromRGBO(18, 18, 18, 1),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      width: 100,
                      height: 100,
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.name,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const Text('Type: Insect')
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    widget.desc,
                    textAlign: TextAlign.justify,
                  ),
                  const Text(
                    'Where to find',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    widget.inWhere,
                    textAlign: TextAlign.justify,
                  ),
                  const Text(
                    'Damage',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    widget.inDamage,
                    textAlign: TextAlign.justify,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
