import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ido_explorer/data/chart_service.dart';
import 'package:ido_explorer/models/chart_delegation.dart';

class DelegationsChart extends StatefulWidget {
  @override
  _DelegationsChartState createState() => _DelegationsChartState();
}

class _DelegationsChartState extends State<DelegationsChart> {
  bool _loading;
  var delegationsList;

  void getChartData() async {
    APIChartService delegationsChart = APIChartService();
    await delegationsChart.getDelegationsChart();
    delegationsList = delegationsChart.chartDelegation;
    setState(() {
      _loading = false;
    });
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
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
        : Stack(
            children: <Widget>[
              SizedBox(
                width: 500,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                  child: LineChart(
                    mainData(),
                  ),
                ),
              ),
            ],
          );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
              const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            //var _r = DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000).toString();
            
            
            /*
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
          
            }
            */
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return '1';
              case 2:
                return '50';
              case 3:
                return '100';
              case 4:
                return '250';
              case 5:
                return '500';
              case 6:
                return '1000';
              case 7:
                return '2500';
              case 8:
                return '5000';
              case 9:
                return '10,000';
              case 10:
                return '50,000';
              case 11:
                return '100,000';
            }
            return '';
          },
          reservedSize: 28,
          margin: 0,
        ),
      ),
      borderData:
          FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: delegationsList[0].timestamp,
      maxX: delegationsList.last.timestamp,
      minY: 0,
      maxY: (delegationsList.last.delegations * 2),
      lineBarsData: measurementsData(delegationsList),
    );
  }

  List<LineChartBarData> measurementsData(List<ChartDelegation> mlist) {
    LineChartBarData lineChart = LineChartBarData(
      spots: [
        for (var items in mlist.toList()) FlSpot(items.timestamp, items.delegations),
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
    return [lineChart];
  }
}
