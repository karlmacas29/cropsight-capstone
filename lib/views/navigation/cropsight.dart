import 'package:cropsight/services/insects.dart';
import 'package:cropsight/views/descript/information.dart';
import 'package:flutter/material.dart';

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
          'Green leafhoppers are the most common leafhoppers in rice fields and are primarily critical because they spread the viral disease tungro. Both nymphs and adults feed by extracting plant sap with their needle-shaped mouthparts.',
      inWhere:
          'Grasses found near irrigation canals and levees, and rice ratoons are favorable for feeding and egg-laying. Tillering and panicle initiation stages are most favorable for their multiplication, although seedling to booting stages are also susceptible. They jump readily when disturbed. They are active in summer and become sluggish during cold weather. Thus, their numbers decline drastically. To quickly detect them, either tap vigorously several plants, stopping now and then as one walks through a field, or sweep rice foliage with an insect net.',
      inDamage:
          'Adults and nymphs cause direct damage to the rice plant by sucking the sap from leaf sheaths and leaf blades. GLH also cause indirect damage by injecting toxic chemicals and transmitting viruses (tungro, dwarf, transitory yellowing, and yellow- orange leaf) and a mycoplasma disease (yellow dwarf). They mostly confine themselves and feed on the leaf and leaf sheath of rice. Mild infestations reduce plant vigor and number of productive tillers. Heavy infestations cause withering and complete drying of the crop.',
    ),
    Insects(
      inPic:
          'http://www.knowledgebank.irri.org/images/stories/leaf-folder-moth.jpg',
      inName: 'Rice Leaffolder',
      inDesc:
          'Leaffolder caterpillars fold a rice leaf around themselves and attach the leaf margins together with silk strands.',
      inWhere:
          'Leaffolders live in all environments but are abundant during the rainy season. High humidity, shady areas of the field, and excessive use of nitrogenous fertilizers favor their rapid multiplication.',
      inDamage:
          'Leaffolders inflict damage in the larva stage. Plants are susceptible to attack up to 10 weeks after transplanting (i.e., from seedling to flowering). Infestation usually occurs during early growth stages of the rice crop. The larvae infest the leaves of young plants; they fasten the edges of a leaf together and live inside the rolled leaf. Heavy infestation makes the plant look burnt, sickly, and twig-like.',
    ),
    Insects(
      inPic:
          'http://www.knowledgebank.irri.org/images/stories/factsheet-ricebug-2.jpg',
      inName: 'Rice Bug',
      inDesc:
          'Rice bugs damage rice by sucking out the contents of developing grains from pre-flowering spikelets to soft dough stage, therefore causing unfilled or empty grains and discoloration. Immature and adult rice bugs both feed on rice grains.',
      inWhere:
          'Bugs are found in all environments but are prevalent in rainfed wetland or upland rice. They are destructive in areas where rainfall is evenly distributed throughout the year, and also in irrigated crops. Extensive weedy areas of rice fields, wild grasses near canals, staggered rice planting, rice fields adjacent to woodlands, and coconut plantations favor bug multiplication. Susceptible growth stages are from flowering to milky stage.',
      inDamage:
          'Adults and nymphs appear in the young crop with the early rains. They suck sap from the developing grains at the milky stage. All soft milky grains are susceptible to attack. Panicles in heavily infested fields remain erect. Insect attack results in discolored or shriveled grains; off-smell of raw and cooked rice, and off-flavor of straws, which is unattractive to cattle. Before grain formation, the bugs feed on succulent shoots and leaves. Nymphs cause more damage than adults.',
    ),
    Insects(
      inPic: 'http://www.knowledgebank.irri.org/images/stories/stem-borer.jpg',
      inName: 'Stem Borer',
      inDesc:
          'Stem borers can destroy rice at any stage of the plant from seedling to maturity.',
      inWhere:
          'The stem borer larvae bore at the base of the plants during the vegetative stage. On older plants, they bore through the upper nodes and feed toward the base. The yellow stem borer is a pest of deepwater rice. It is found in aquatic environments where there is continuous flooding. Second instar larvae enclose themselves in body leaf wrappings to make tubes and detach themselves from the leaf and falls onto the water surface. They attach themselves to the tiller and bore into the stem.',
      inDamage:
          'Yellow stem borer is a notorious pest of deepwater rice. It is abundant in aquatic habitats where flooding occurs and where multiple rice crops are grown annually. Rice plants at the vegetative and early heading stages are preferred for egg-laying. Plants receiving high nitrogenous fertilizers are also favorable to larval survival. Only one larva can be found in a stem. To detect the presence of moth, flush the borders of the field. To monitor larval densities, dissect tillers at tiller elongation and panicle initiation stages. For eggmasses, check seedbed or newly established crop at weekly intervals starting 3 weeks after transplanting up to 9 WAT. Egg-laying can peak at 3.5 eggmass/m². White Stem Borer: Predominant in rainfed areas where there is only one wet season crop per year, and where stubbles are left undisturbed during the dry season. Upland rice is susceptible to WSB species, as the larvae cannot survive extremely wet situations. Thus, this insect does not occur in areas with high rainfall. Early in the season, deadhearts are caused in the nurseries and in the young crop, while later in the cropping season subsequent generations cause whiteheads. WSB is presently found in the Visayas and Mindanao.',
    ),
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
            elevation: const WidgetStatePropertyAll(0.0),
            onChanged: _filterItems,
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20)),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black),
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
          Visibility(
              visible: true,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
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
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.black,
                          selectedTileColor: Colors.green,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoPage(
                                          image: insectSearch.inPic,
                                          name: insectSearch.inName,
                                          desc: insectSearch.inDesc,
                                          inWhere: insectSearch.inWhere,
                                          inDamage: insectSearch.inDamage,
                                        )));
                          },
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
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
        ],
      ),
    );
  }
}
