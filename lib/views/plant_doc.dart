import 'package:flutter/material.dart';
import 'package:smart_farm/views/tab1.dart';
import 'package:smart_farm/views/tab2.dart';

class PlantDoc extends StatefulWidget {
  const PlantDoc({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlantDocState createState() => _PlantDocState();
}

class _PlantDocState extends State<PlantDoc>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                // height: 50,
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelColor: Colors.white,
                        labelColor: Colors.green,
                        indicatorColor: Colors.white,
                        indicatorWeight: 2,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        controller: tabController,
                        tabs: const [
                          Tab(
                            text: 'Plant Care',
                          ),
                          Tab(
                            child: Text(
                              'Disease detection',
                              softWrap: false,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: const [
                    Tab2(),
                    Tab1(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
