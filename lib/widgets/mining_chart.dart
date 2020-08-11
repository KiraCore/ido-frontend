import 'package:IDO_Kira/models/chart_mining_model.dart';
import 'package:IDO_Kira/services/chart_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MiningChart extends StatefulWidget {
  @override
  _MiningChartState createState() => _MiningChartState();
}

class _MiningChartState extends State<MiningChart> {
  bool _loading;
  var miningList;

  void getChartData() async {
    ChartService minerIdoChart = ChartService();
    await minerIdoChart.getMinerChart();
    miningList = minerIdoChart.chartIdoMining;
    setState(() {
      _loading = false;
    });
  }

  List<Color> gradientColors = [
    //const Color(0xff23b6e6),
    //const Color(0xff02d39a),
    Colors.deepOrange,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    const Color.fromRGBO(103, 58, 183, 1),
  ];

  @override
  void initState() {
    _loading = true;
    super.initState();
    getChartData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  mainData(),
                ),
              ),
            ));
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 22,
          textStyle: const TextStyle(color: Color(0xff68737d), fontSize: 10),
          getTitles: (value) {
            /*
            switch (value.toInt()) {
              case 0:
                return 'Jan';
              case 2:
                return 'Mar';
              case 5:
                return 'Jun';
              case 7:
                return 'Aug';
              case 9:
                return 'Oct';
            }
            */
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff7e9195),
            fontSize: 10,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 25:
                return '50';
              case 50:
                return '50';
              case 100:
                return '100';
              case 250:
                return '250';
              case 500:
                return '500';
              case 750:
                return '750';
              case 1000:
                return '1k';
              case 2500:
                return '2.5k';
              case 5000:
                return '5k';
              case 10000:
                return '10k';
              case 25000:
                return '25k';
              case 50000:
                return '50k';
              case 75000:
                return '75k';
              case 100000:
                return '100k';
              case 250000:
                return '250k';
              case 500000:
                return '500k';
              case 750000:
                return '750k';
              case 1000000:
                return '1M';
              case 2500000:
                return '2.5M';
              case 5000000:
                return '5M';
              case 7500000:
                return '7.5M';
              case 10000000:
                return '10M';
              case 25000000:
                return '25M';
              case 50000000:
                return '50M';
              case 75000000:
                return '75M';
              case 100000000:
                return '100M';
              case 200000000:
                return '200M';
              case 300000000:
                return '300M';
              case 400000000:
                return '400M';
              case 500000000:
                return '500M';
              case 750000000:
                return '500M';
              case 1000000000:
                return '1B';
              case 5000000000:
                return '5B';
              case 10000000000:
                return '10B';
              case 50000000000:
                return '50B';
            }
            return '';
          },
          reservedSize: 30,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: miningList[0].timestamp,
      maxX: miningList.last.timestamp,
      minY: 0,
      maxY: (miningList.last.hash * 1.15),
      lineBarsData: measurementsData(miningList),
    );
  }

  List<LineChartBarData> measurementsData(List<ChartMiningModel> mlist) {
    LineChartBarData lineChart = LineChartBarData(
      spots: [
        for (var items in mlist.toList()) FlSpot(items.timestamp, items.hash),
      ],
      isCurved: true,
      colors: gradientColors,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      ),
    );
    return [
      lineChart
    ];
  }
}
