import 'package:IDO_Kira/widgets/ido_delegation_Chart.dart';
import 'package:IDO_Kira/widgets/income_Chart.dart';
import 'package:IDO_Kira/widgets/mining_chart.dart';

import 'package:flutter/material.dart';

class IdoChart extends StatelessWidget {
  const IdoChart({
    Key key,
    @required TabController tabChartController,
  })  : _tabChartController = tabChartController,
        super(key: key);

  final TabController _tabChartController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black,
      appBar: TabBar(labelColor: Colors.black, indicatorColor: Colors.deepPurple, controller: _tabChartController, tabs: [
        Tab(
          child: Text(
            'Delegations',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Tab(
          child: Text(
            'Funds Comitted',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Tab(
          child: Text(
            'Mined',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ]),
      body: Container(
        color: Colors.white,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabChartController,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  IdoDelegationChart()
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  IncomeChart()
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MiningChart()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
