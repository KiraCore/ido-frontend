import 'package:IDO_Kira/models/chart_delegationModel.dart';
import 'package:IDO_Kira/services/chart_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DelegatorDelegationChart extends StatefulWidget {
  String address;
  DelegatorDelegationChart({this.address});

  @override
  _DelegatorDelegationChartState createState() => _DelegatorDelegationChartState();
}

class _DelegatorDelegationChartState extends State<DelegatorDelegationChart> {
  bool _loading;
  var delegatorDelegationList;

  void getChartData() async {
    ChartService delegationChart = ChartService();
    await delegationChart.getDelegatorDelegationChart(address: widget.address);
    delegatorDelegationList = delegationChart.chartDelegatorDelegation;
    setState(() {
      _loading = false;
    });
  }

  List<Color> gradientColors = [
    Colors.orange[800],
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
        show: false,
        drawVerticalLine: false,
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
        show: false,
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 0, //22
          textStyle: const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
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
          margin: 0, //8
        ),
        leftTitles: SideTitles(
          showTitles: false,
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
          reservedSize: 0, //25
          margin: 0,
        ),
      ),
      borderData: FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: delegatorDelegationList[0].timestamp,
      maxX: delegatorDelegationList.last.timestamp,
      minY: 0,
      maxY: (delegatorDelegationList.last.delegations * 3),
      lineBarsData: measurementsData(delegatorDelegationList),
    );
  }

  List<LineChartBarData> measurementsData(List<ChartDelegationModel> mlist) {
    LineChartBarData lineChart = LineChartBarData(
      spots: [
        for (var items in mlist.toList())
          FlSpot(
            items.timestamp,
            double.parse((items.delegations.toStringAsFixed(2))),
          )
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
