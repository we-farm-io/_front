import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_farm/features/profile/models/entity.dart';
import 'package:smart_farm/features/profile/widgets/customentry.dart';

class AnimalsPage extends StatefulWidget {
  const AnimalsPage({super.key});

  @override
  State<AnimalsPage> createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  List<Entity> crops = [];

  void _addCrop(BuildContext context) {
    String name = '';
    String quantity = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Animal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: const InputDecoration(labelText: 'Animal Name'),
              ),
              TextField(
                onChanged: (value) {
                  quantity = value;
                },
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  crops.add(Entity(name, int.tryParse(quantity) ?? 0));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton: IconButton(
        icon: SvgPicture.asset('assets/icons/Profile/message-add.svg'),
        onPressed: () {
          _addCrop(context);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: const Color(0xFF0D986A),
                    height: mediaQuery.size.height / 4,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: Transform.scale(
                    scaleX: 1.3,
                    child: IconButton(
                      icon: SvgPicture.asset("assets/icons/arrow-left.svg"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: mediaQuery.size.height / 10,
                  right: 0,
                  left: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 69,
                        child: Image.asset(
                            'assets/icons/Profile/animals_profile.png'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Animals",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        height: 65 * mediaQuery.size.height / 100,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: crops.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Text(
                                          crops[index].name,
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    CustomEntry(
                                      hintText: crops[index].value.toString(),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      // Add other widgets as needed
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
