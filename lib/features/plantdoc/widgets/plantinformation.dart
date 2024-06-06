import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/plantdoc/models/plant_species.dart';
import 'package:smart_farm/features/plantdoc/providers/plantgrowth_provider.dart';
import 'package:smart_farm/features/plantdoc/screens/plant_info_screen.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Tab2 extends StatefulWidget {
  const Tab2({super.key});

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlantProvider>(builder: (context, provider, _) {
      return Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: provider.controller,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.search,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Palette.buttonGreen),
                borderRadius: BorderRadius.circular(16),
              ),
              hintStyle: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                //borderSide: const BorderSide(color: Palette.textBlue),
              ),
              prefixIcon: Transform.scale(
                  scale: 1.2, child: Image.asset('assets/icons/Search.png')),
            ),
            onSubmitted: (String plantname) {
              provider.fetchPlantSpecies(plantname);
            },
          ),
          Builder(
            builder: (context) {
              if (provider.isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.species.length,
                    itemBuilder: (context, index) {
                      PlantSpecies species = provider.species[index];
                      return GestureDetector(
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          await provider
                              .fetchPlantGrowth(provider.species[index].id!);
                          navigator.push(MaterialPageRoute(
                              builder: (context) => PlantInformation(
                                  provider.plantInfo, species.photoUrl!)));
                        },
                        child: Card(
                          color: Colors.lightGreen,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (species.photoUrl != null)
                                  Container(
                                    width: double.infinity,
                                    height: 200, // Adjust height as needed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          8), // Rounded corners
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            species.photoUrl!),
                                        fit: BoxFit
                                            .cover, // Cover the entire container
                                      ),
                                    ),
                                  ),
                                Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        species.scientificName ??
                                            "No Scientific Name",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              4), // Adjust spacing between scientific name and common name
                                      Text(
                                        species.commonName ?? "No Common Name",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ), // Adjust spacing between image and text
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      );
    });
  }
}
