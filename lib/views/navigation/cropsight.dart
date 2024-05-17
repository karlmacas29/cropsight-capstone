import 'package:cropsight/services/insects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CropsightTab extends StatefulWidget {
  const CropsightTab({super.key});

  @override
  State<CropsightTab> createState() => _CropsightTabState();
}

class _CropsightTabState extends State<CropsightTab> {
  List<Insects> insects = [
    Insects(
        inPic:
            'http://www.knowledgebank.irri.org/images/stories/factsheet-green-leafhopper-1.jpg',
        inName: 'Green LeafHopper',
        inDesc:
            'Green leafhoppers are the most common leafhoppers in rice fields and are primarily critical because they spread the viral disease tungro. Both nymphs and adults feed by extracting plant sap with their needle-shaped mouthparts.'),
    Insects(
        inPic:
            'http://www.knowledgebank.irri.org/images/stories/leaf-folder-moth.jpg',
        inName: 'Rice Leaffolder',
        inDesc:
            'Leaffolder caterpillars fold a rice leaf around themselves and attach the leaf margins together with silk strands.'),
    Insects(
        inPic:
            'http://www.knowledgebank.irri.org/images/stories/factsheet-ricebug-2.jpg',
        inName: 'Rice Bug',
        inDesc:
            'Rice bugs damage rice by sucking out the contents of developing grains from pre-flowering spikelets to soft dough stage, therefore causing unfilled or empty grains and discoloration. Immature and adult rice bugs both feed on rice grains.'),
    Insects(
        inPic:
            'http://www.knowledgebank.irri.org/images/stories/stem-borer.jpg',
        inName: 'Stem Borer',
        inDesc:
            'Stem borers can destroy rice at any stage of the plant from seedling to maturity.'),
  ];

  late List<Insects> filteredItems;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredItems = insects;
  }

  void _filterItems(String query) {
    setState(() {
      searchQuery = query;
      if (searchQuery.isEmpty) {
        filteredItems = insects;
      } else {
        final startsWithQuery = insects
            .where((insect) => insect.inName
                .toLowerCase()
                .startsWith(searchQuery.toLowerCase()))
            .toList();
        final containsQuery = insects
            .where((insect) =>
                insect.inName
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()) &&
                !insect.inName
                    .toLowerCase()
                    .startsWith(searchQuery.toLowerCase()))
            .toList();
        filteredItems = [...startsWithQuery, ...containsQuery];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBar(
            elevation: const MaterialStatePropertyAll(0.0),
            onChanged: _filterItems,
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20)),
            backgroundColor: const MaterialStatePropertyAll(
                Color.fromARGB(255, 233, 238, 234)),
            hintText: 'Search...',
            keyboardType: TextInputType.text,
            trailing: const [Icon(Icons.search_rounded)],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Rice Pest Lists',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              child: Visibility(
                  visible: true,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      physics: const BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.normal),
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final insectSearch = filteredItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Material(
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              tileColor:
                                  const Color.fromARGB(255, 233, 238, 234),
                              selectedTileColor: Colors.green,
                              onTap: () {},
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  width: 50,
                                  height: 50,
                                  insectSearch.inPic,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(insectSearch.inName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                insectSearch.inDesc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  )) //

              ),
        ],
      ),
    );
  }
}
