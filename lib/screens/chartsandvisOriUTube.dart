//2021-12-26 KEEP for v1 - Maybe useful for sample code
// Script from:  Mins 7:35 @  https://www.youtube.com/watch?v=QshpV3gh708

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ImpCharts extends StatefulWidget {
  const ImpCharts({Key? key}) : super(key: key);

  @override
  _ImpChartsState createState() => _ImpChartsState();
}

class _ImpChartsState extends State<ImpCharts> {
  static final List<WorldPopulation> populationData = [
    WorldPopulation('2016', 54, Colors.pink),
    WorldPopulation('2017', 23, Colors.purple),
    WorldPopulation('2018', 74, Colors.yellow),
    WorldPopulation('2019', 84, Colors.amber),
    WorldPopulation('2020', 94, Colors.green),
    WorldPopulation('2021', 99, Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<WorldPopulation, String>> series = [
      charts.Series(
          data: populationData,
          id: "World Population",
          domainFn: (WorldPopulation pops, _) => pops.year,
          measureFn: (WorldPopulation pops, _) => pops.population,
          colorFn: (WorldPopulation pops, _) =>
              charts.ColorUtil.fromDartColor(pops.barColor))
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("chartsandvisOriUTube.dt"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: charts.BarChart(series),
          ),
        ),
      ),
    );
  }
}

class WorldPopulation {
  final String year;
  final int population;
  final Color barColor;

  WorldPopulation(this.year, this.population, this.barColor);
}
