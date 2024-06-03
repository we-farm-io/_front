import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

String currentUser = FirebaseAuth.instance.currentUser!.uid;

Map<String, dynamic> processQuerySnapshot(QuerySnapshot? querySnapshot) {
  Map<String, double> documentMap = {};
  double totalQuantity = 0;
  if (querySnapshot != null) {
    for (var doc in querySnapshot.docs) {
      documentMap[doc.id] = doc['totalQuantity'].toDouble();
      totalQuantity += doc['totalQuantity'];
    }

    return {
      'documents': documentMap,
      'total_quantity': totalQuantity,
    };
  } else {
    print('was null');
    return {'documents': {}, 'total_quantity': totalQuantity};
  }
}

QuerySnapshot? cropsSnapchot;
QuerySnapshot? animalsSnapchot;
QuerySnapshot? materialsSnapchot;
Future<void> _getdocuments() async {
  print('starterd');
  cropsSnapchot = await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser)
      .collection('crops')
      .get();
  print("finish1");
  animalsSnapchot = await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser)
      .collection('animals')
      .get();
  materialsSnapchot = await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser)
      .collection('materials')
      .get();
  print("ifnished");
}

class _StatisticsPageState extends State<StatisticsPage> {
  Map<String, double> crops = {};
  Map<String, double> cropsvalues = {};
  Map<String, double> animalsvalues = {};
  Map<String, double> materialsvalues = {};

  Map<String, double> animals = {};
  Map<String, double> materials = {};
  Map<String, double> totalmaterials = {};
  Map<String, double> totalanimals = {};
  Map<String, double> totalcrops = {};
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cropscolor = <Color>[
      const Color(0xff4318FF),
      const Color(0xff6AD2FF),
      const Color(0xff00B69B),
    ];
    final animalscolor = <Color>[
      const Color(0xffF2D406),
      const Color(0xffFF3D00),
      const Color(0xff34C759),
    ];
    final materialscolor = <Color>[
      const Color(0xffFF0000),
      const Color(0xffF758E7),
      const Color(0xff6AD2FF),
    ];
    final totalmaterialcolor = <Color>[
      const Color(0xff00B074),
    ];
    final totalanimalscolor = <Color>[
      const Color(0xffFF5B5B),
    ];
    final totalcropscolor = <Color>[
      const Color(0xff2D9CDB),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset("assets/icons/Profile/back_arrow.svg")),
        centerTitle: true,
        title: const Text(
          "My statistics",
          style: TextStyle(
              color: Color(0xFF404040),
              fontFamily: "Poppins ",
              fontWeight: FontWeight.w500,
              fontSize: 24),
        ),
      ),
      body: FutureBuilder(
          future: _getdocuments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final Map<String, dynamic> processedanimals =
                  processQuerySnapshot(animalsSnapchot);
              final Map<String, dynamic> processedmaterials =
                  processQuerySnapshot(materialsSnapchot);
              final Map<String, dynamic> processedcrops =
                  processQuerySnapshot(cropsSnapchot);

              crops = processedcrops['documents'];
              animals = processedanimals['documents'];
              materials = processedmaterials['documents'];
              totalanimals = {
                "data": processedanimals['total_quantity'] as double
              };
              totalcrops = {'data': processedcrops['total_quantity'] as double};
              totalmaterials = {"data": processedmaterials['total_quantity']};

              double? total = totalanimals['data']! +
                  totalmaterials['data']! +
                  totalcrops['data']!;

              ///
// Assuming crops, animals, materials, totalcrops, totalanimals, and totalmaterials are defined appropriately

// Sorting and adding values for crops
              var sortedCrops = crops.entries.toList()
                ..sort((a, b) => b.value.compareTo(a.value));
              cropsvalues.addEntries({
                "others": totalcrops["data"]! -
                    ((sortedCrops.isEmpty ? 0 : sortedCrops[0].value) +
                        (sortedCrops.length < 2 ? 0 : sortedCrops[1].value))
              }.entries);

              if (sortedCrops.isNotEmpty) {
                cropsvalues.addEntries(
                    {sortedCrops[0].key: sortedCrops[0].value}.entries);
              }
              if (sortedCrops.length >= 2) {
                cropsvalues.addEntries(
                    {sortedCrops[1].key: sortedCrops[1].value}.entries);
              }

// Sorting and adding values for animals
              var sortedAnimals = animals.entries.toList()
                ..sort((a, b) => b.value.compareTo(a.value));
              animalsvalues.addEntries({
                "others": totalanimals["data"]! -
                    ((sortedAnimals.isEmpty ? 0 : sortedAnimals[0].value) +
                        (sortedAnimals.length < 2 ? 0 : sortedAnimals[1].value))
              }.entries);

              if (sortedAnimals.isNotEmpty) {
                animalsvalues.addEntries(
                    {sortedAnimals[0].key: sortedAnimals[0].value}.entries);
              }
              if (sortedAnimals.length >= 2) {
                animalsvalues.addEntries(
                    {sortedAnimals[1].key: sortedAnimals[1].value}.entries);
              }

// Sorting and adding values for materials
              var sortedMaterials = materials.entries.toList()
                ..sort((a, b) => b.value.compareTo(a.value));
              materialsvalues.addEntries({
                "others": totalmaterials["data"]! -
                    ((sortedMaterials.isEmpty ? 0 : sortedMaterials[0].value) +
                        (sortedMaterials.length < 2
                            ? 0
                            : sortedMaterials[1].value))
              }.entries);

              if (sortedMaterials.isNotEmpty) {
                materialsvalues.addEntries(
                    {sortedMaterials[0].key: sortedMaterials[0].value}.entries);
              }
              if (sortedMaterials.length >= 2) {
                materialsvalues.addEntries(
                    {sortedMaterials[1].key: sortedMaterials[1].value}.entries);
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 6.5),
                              ],
                              color: Colors.white,
                            ),
                            height: 120,
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${totalcrops["data"]} kg",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                        color: Color(0xFF280559),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    "Crops",
                                    style: TextStyle(
                                        color: Color(0xFF92929D),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/Profile/increase.svg",
                                      ),
                                      const Text(
                                        "12%",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFA3A3A3),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 6.5),
                              ],
                              color: Colors.white,
                            ),
                            height: 120,
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${totalanimals["data"]}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                        color: Color(0xFF280559),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    "Animals",
                                    style: TextStyle(
                                        color: Color(0xFF92929D),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/Profile/increase.svg",
                                      ),
                                      const Text(
                                        "12%",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFA3A3A3),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 6.5),
                              ],
                              color: Colors.white,
                            ),
                            height: 120,
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${totalmaterials["data"]}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                        color: Color(0xFF280559),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    "Materials",
                                    style: TextStyle(
                                        overflow: TextOverflow.visible,
                                        color: Color(0xFF92929D),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/Profile/increase.svg",
                                      ),
                                      const Text(
                                        "12%",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFA3A3A3),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 6.5),
                          ],
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width - 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                    child: PieChart(
                                      chartRadius: 70,
                                      legendOptions: const LegendOptions(
                                          showLegends: false),
                                      dataMap: {
                                        "data":
                                            (totalmaterials["data"]! / total ==
                                                        0
                                                    ? 1
                                                    : total) *
                                                100
                                      },
                                      chartType: ChartType.ring,
                                      baseChartColor: totalmaterialcolor[0]
                                          .withOpacity(0.25),
                                      colorList: totalmaterialcolor,
                                      chartValuesOptions:
                                          const ChartValuesOptions(
                                        showChartValues: false,
                                      ),
                                      initialAngleInDegree: 0,
                                      totalValue: 100,
                                      centerWidget: Text(
                                        "${((totalmaterials["data"]! / (total == 0 ? 1 : total)) * 100).toInt()}%",
                                        style: const TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    textAlign: TextAlign.center,
                                    "Total\nMaterials",
                                    style: TextStyle(
                                        color: Color(0xFF464255),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                    child: PieChart(
                                      chartRadius: 70,
                                      legendOptions: const LegendOptions(
                                          showLegends: false),
                                      dataMap: {
                                        "data":
                                            (totalanimals["data"]! / total == 0
                                                    ? 1
                                                    : total) *
                                                100
                                      },
                                      chartType: ChartType.ring,
                                      baseChartColor: totalanimalscolor[0]
                                          .withOpacity(0.25),
                                      colorList: totalanimalscolor,
                                      chartValuesOptions:
                                          const ChartValuesOptions(
                                        showChartValues: false,
                                      ),
                                      initialAngleInDegree:
                                          (totalmaterials["data"]! / total == 0
                                                  ? 1
                                                  : total) *
                                              360,
                                      totalValue: 100,
                                      degreeOptions: const DegreeOptions(
                                          initialAngle: 0, totalDegrees: 360),
                                      centerWidget: Text(
                                        "${((totalanimals["data"]! / (total == 0 ? 1 : total)) * 100).toInt()}%",
                                        style: const TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    textAlign: TextAlign.center,
                                    "Total\nAnimals",
                                    style: TextStyle(
                                        color: Color(0xFF464255),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                    child: PieChart(
                                      chartRadius: 70,
                                      legendOptions: const LegendOptions(
                                          showLegends: false),
                                      dataMap: {
                                        "data": totalcrops["data"]! /
                                            (total == 0 ? 1 : total) *
                                            100
                                      },
                                      chartType: ChartType.ring,
                                      baseChartColor:
                                          totalcropscolor[0].withOpacity(0.25),
                                      colorList: totalcropscolor,
                                      chartValuesOptions:
                                          const ChartValuesOptions(
                                        showChartValues: false,
                                      ),
                                      initialAngleInDegree: (totalmaterials[
                                                          "data"]! +
                                                      totalanimals["data"]!) /
                                                  total ==
                                              0
                                          ? 1
                                          : total * 360,
                                      totalValue: 100,
                                      centerWidget: Text(
                                        "${((totalcrops["data"]! / (total == 0 ? 1 : total)) * 100).toInt()}%",
                                        style: const TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    textAlign: TextAlign.center,
                                    "Total\nCrops",
                                    style: TextStyle(
                                        color: Color(0xFF464255),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 6.5),
                          ],
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width - 20,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                child: Text(
                                  "Crops Pie Chart",
                                  style: TextStyle(
                                      color: Color(0xff2B3674),
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            PieChart(
                              dataMap: cropsvalues,
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartRadius:
                                  (MediaQuery.of(context).size.width + 40) / 3,
                              colorList: cropscolor,
                              initialAngleInDegree: 0,
                              chartType: ChartType.disc,
                              ringStrokeWidth: 32,
                              legendOptions: const LegendOptions(
                                showLegends: false,
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValues: false,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 6.5),
                                  ],
                                  color: Colors.white,
                                ),
                                width: MediaQuery.of(context).size.width - 100,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //Todo i need to loop this shit
                                    if (crops.keys.toList().isNotEmpty)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                child: Icon(
                                                  Icons.circle,
                                                  size: 10,
                                                  color: cropscolor[1],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    cropsvalues.keys
                                                        .toList()[1]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffA3AED0),
                                                        fontFamily: "Poppins",
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Text(
                                            "${((cropsvalues.values.toList()[1].toInt() / totalcrops["data"]! == 0 ? 1 : totalcrops["data"]!) * 100).toInt()}%",
                                            style: const TextStyle(
                                                color: Color(0xFF2B3674),
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
//todo this is the second column
                                    if (crops.keys.toList().length >= 2)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                child: Icon(
                                                  Icons.circle,
                                                  size: 10,
                                                  color: cropscolor[2],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    cropsvalues.keys
                                                        .toList()[2]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffA3AED0),
                                                        fontFamily: "Poppins",
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Text(
                                            "${((cropsvalues.values.toList()[2].toInt() / totalcrops["data"]! == 0 ? 1 : totalcrops["data"]!) * 100).toInt()}%",
                                            style: const TextStyle(
                                                color: Color(0xFF2B3674),
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    //todo this is the others column put it's logic here
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              child: Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: cropscolor[0],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  cropsvalues.keys.toList()[0],
                                                  style: const TextStyle(
                                                      color: Color(0xffA3AED0),
                                                      fontFamily: "Poppins",
                                                      fontSize: 14),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(
                                          "${((cropsvalues.values.toList()[0].toInt() / totalcrops["data"]! == 0 ? 1 : totalcrops["data"]!) * 100).toInt()}%",
                                          style: const TextStyle(
                                              color: Color(0xFF2B3674),
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    //todo loooooooooooooooooooooop
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 6.5),
                          ],
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width - 20,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                child: Text(
                                  "Animals Pie Chart",
                                  style: TextStyle(
                                      color: Color(0xff2B3674),
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            PieChart(
                              dataMap: animalsvalues,
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartRadius:
                                  (MediaQuery.of(context).size.width + 40) / 3,
                              colorList: animalscolor,
                              initialAngleInDegree: 0,
                              chartType: ChartType.disc,
                              ringStrokeWidth: 32,
                              legendOptions: const LegendOptions(
                                showLegends: false,
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValues: false,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 6.5),
                                  ],
                                  color: Colors.white,
                                ),
                                width: MediaQuery.of(context).size.width - 100,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //here
                                    //todo Animals todo
                                    if (animals.keys.toList().isNotEmpty)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                child: Icon(
                                                  Icons.circle,
                                                  size: 10,
                                                  color: animalscolor[1],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    animalsvalues.keys
                                                        .toList()[1]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffA3AED0),
                                                        fontFamily: "Poppins",
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Text(
                                            "${((animalsvalues.values.toList()[1].toInt() / totalanimals["data"]! == 0 ? 1 : totalanimals["data"]!) * 100).toInt()}%",
                                            style: const TextStyle(
                                                color: Color(0xFF2B3674),
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
//todo this is the second column
                                    if (animals.keys.toList().length >= 2)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                child: Icon(
                                                  Icons.circle,
                                                  size: 10,
                                                  color: animalscolor[2],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    animalsvalues.keys
                                                        .toList()[2]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffA3AED0),
                                                        fontFamily: "Poppins",
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Text(
                                            "${((animalsvalues.values.toList()[2].toInt() / totalanimals["data"]! == 0 ? 1 : totalanimals["data"]!) * 100).toInt()}%",
                                            style: const TextStyle(
                                                color: Color(0xFF2B3674),
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    //todo this is the others column put it's logic here
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              child: Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: animalscolor[0],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  animalsvalues.keys
                                                      .toList()[0],
                                                  style: const TextStyle(
                                                      color: Color(0xffA3AED0),
                                                      fontFamily: "Poppins",
                                                      fontSize: 14),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(
                                          "${((animalsvalues.values.toList()[0].toInt() / totalanimals["data"]! == 0 ? 1 : totalanimals["data"]!) * 100).toInt()}%",
                                          style: const TextStyle(
                                              color: Color(0xFF2B3674),
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    //todo loooooooooooooooooooooop
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 6.5),
                          ],
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width - 20,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                child: Text(
                                  "Materials Pie Chart",
                                  style: TextStyle(
                                      color: Color(0xff2B3674),
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            PieChart(
                              dataMap: materialsvalues,
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartRadius:
                                  (MediaQuery.of(context).size.width + 40) / 3,
                              colorList: materialscolor,
                              initialAngleInDegree: 0,
                              chartType: ChartType.disc,
                              ringStrokeWidth: 32,
                              legendOptions: const LegendOptions(
                                showLegends: false,
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValues: false,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 6.5),
                                  ],
                                  color: Colors.white,
                                ),
                                width: MediaQuery.of(context).size.width - 100,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //todo materials todo
                                    if (materials.keys.toList().isNotEmpty)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                child: Icon(
                                                  Icons.circle,
                                                  size: 10,
                                                  color: materialscolor[1],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    materialsvalues.keys
                                                        .toList()[1]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffA3AED0),
                                                        fontFamily: "Poppins",
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Text(
                                            "${((materialsvalues.values.toList()[1].toInt() / (totalmaterials["data"] == 0 ? 1 : totalmaterials["data"]!)) * 100).toInt()}%",
                                            style: const TextStyle(
                                                color: Color(0xFF2B3674),
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
//todo this is the second column
                                    if (materials.keys.toList().length >= 2)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                child: Icon(
                                                  Icons.circle,
                                                  size: 10,
                                                  color: materialscolor[2],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    materialsvalues.keys
                                                        .toList()[2]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffA3AED0),
                                                        fontFamily: "Poppins",
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Text(
                                            "${((materialsvalues.values.toList()[2].toInt() / (totalmaterials["data"] == 0 ? 1 : totalmaterials["data"]!)) * 100).toInt()}%",
                                            style: const TextStyle(
                                                color: Color(0xFF2B3674),
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    //todo this is the others column put it's logic here
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              child: Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: materialscolor[0],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  materialsvalues.keys
                                                      .toList()[0],
                                                  style: const TextStyle(
                                                      color: Color(0xffA3AED0),
                                                      fontFamily: "Poppins",
                                                      fontSize: 14),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(
                                          "${((materialsvalues.values.toList()[0].toInt() / (totalmaterials["data"] == 0 ? 1 : totalmaterials["data"]!)) * 100).toInt()}%",
                                          style: const TextStyle(
                                              color: Color(0xFF2B3674),
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
