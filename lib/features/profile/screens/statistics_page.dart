import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final crops = <String, double>{
      "Potato": 58,
      "Tomato": 24,
      "Others": 18,
    };
    final animals = <String, double>{
      "Sheep": 58,
      "Cows": 24,
      "Others": 18,
    };
    final materials = <String, double>{
      "Axes": 58,
      "Wheelbarrows": 24,
      "Others": 18,
    };
    final totalmaterials = <String, double>{
      "data": 16,
    };
    final totalanimals = <String, double>{
      "data": 22,
    };
    final totalcrops = <String, double>{
      "data": 62,
    };
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
      body: Padding(
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "6530",
                            style: TextStyle(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "120",
                            style: TextStyle(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "1054",
                            style: TextStyle(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        color: Colors.black.withOpacity(0.25), blurRadius: 6.5),
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: PieChart(
                              chartRadius: 70,
                              legendOptions:
                                  const LegendOptions(showLegends: false),
                              dataMap: totalmaterials,
                              chartType: ChartType.ring,
                              baseChartColor:
                                  totalmaterialcolor[0].withOpacity(0.25),
                              colorList: totalmaterialcolor,
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValues: false,
                              ),
                              initialAngleInDegree: 0,
                              totalValue: 100,
                              centerWidget: Text(
                                "${totalmaterials["data"]!.toInt()}%",
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: PieChart(
                              chartRadius: 70,
                              legendOptions:
                                  const LegendOptions(showLegends: false),
                              dataMap: totalanimals,
                              chartType: ChartType.ring,
                              baseChartColor:
                                  totalanimalscolor[0].withOpacity(0.25),
                              colorList: totalanimalscolor,
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValues: false,
                              ),
                              initialAngleInDegree:
                                  totalmaterials["data"]! * 360 / 100,
                              totalValue: 100,
                              degreeOptions: const DegreeOptions(
                                  initialAngle: 0, totalDegrees: 360),
                              centerWidget: Text(
                                "${totalanimals["data"]!.toInt()}%",
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: PieChart(
                              chartRadius: 70,
                              legendOptions:
                                  const LegendOptions(showLegends: false),
                              dataMap: totalcrops,
                              chartType: ChartType.ring,
                              baseChartColor:
                                  totalcropscolor[0].withOpacity(0.25),
                              colorList: totalcropscolor,
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValues: false,
                              ),
                              initialAngleInDegree: (totalmaterials["data"]! +
                                      totalanimals["data"]!) *
                                  360 /
                                  100,
                              totalValue: 100,
                              centerWidget: Text(
                                "${totalcrops["data"]!.toInt()}%",
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
                        color: Colors.black.withOpacity(0.25), blurRadius: 6.5),
                  ],
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                      dataMap: crops,
                      animationDuration: const Duration(milliseconds: 800),
                      chartRadius: (MediaQuery.of(context).size.width + 40) / 3,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                          crops.keys.toList()[0],
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
                                  "${crops.values.toList()[0].toInt().toString()}%",
                                  style: const TextStyle(
                                      color: Color(0xFF2B3674),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                          crops.keys.toList()[1],
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
                                  "${crops.values.toList()[1].toInt().toString()}%",
                                  style: const TextStyle(
                                      color: Color(0xFF2B3674),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                          crops.keys.toList()[2],
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
                                  "${crops.values.toList()[2].toInt().toString()}%",
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25), blurRadius: 6.5),
                  ],
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                      dataMap: animals,
                      animationDuration: const Duration(milliseconds: 800),
                      chartRadius: (MediaQuery.of(context).size.width + 40) / 3,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                          animals.keys.toList()[0],
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
                                  "${animals.values.toList()[0].toInt().toString()}%",
                                  style: const TextStyle(
                                      color: Color(0xFF2B3674),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                          animals.keys.toList()[1],
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
                                  "${animals.values.toList()[1].toInt().toString()}%",
                                  style: const TextStyle(
                                      color: Color(0xFF2B3674),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                          animals.keys.toList()[2],
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
                                  "${animals.values.toList()[2].toInt().toString()}%",
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25), blurRadius: 6.5),
                  ],
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                      dataMap: materials,
                      animationDuration: const Duration(milliseconds: 800),
                      chartRadius: (MediaQuery.of(context).size.width + 40) / 3,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                          materials.keys.toList()[0],
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
                                  "${materials.values.toList()[0].toInt().toString()}%",
                                  style: const TextStyle(
                                      color: Color(0xFF2B3674),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                          materials.keys.toList()[1],
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
                                  "${materials.values.toList()[1].toInt().toString()}%",
                                  style: const TextStyle(
                                      color: Color(0xFF2B3674),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                          materials.keys.toList()[2],
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
                                  "${materials.values.toList()[2].toInt().toString()}%",
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
      ),
    );
  }
}
