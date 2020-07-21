import 'package:fl_chart/fl_chart.dart';
import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ido_explorer/data/chart_service.dart';
import 'package:ido_explorer/data/services.dart';
import 'package:ido_explorer/models/global.dart';
import 'package:ido_explorer/models/table_operators.dart';
import 'package:ido_explorer/screens/widgets/custom_appbar.dart';
import 'package:ido_explorer/screens/widgets/custom_card.dart';
import 'package:ido_explorer/screens/widgets/heading_title.dart';
import 'package:ido_explorer/screens/widgets/hidden_card.dart';
import 'package:ido_explorer/screens/widgets/ido_datatable.dart';
import 'package:ido_explorer/screens/widgets/delegations_chart.dart';
import 'package:ido_explorer/screens/widgets/income_chart.dart';
import 'package:ido_explorer/screens/widgets/mining_chart.dart';

class GlobalScreen extends StatefulWidget {
  @override
  _GlobalScreenState createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> with TickerProviderStateMixin {
  TextEditingController searchController = new TextEditingController();
  TabController _tabChartController;
  int touchedIndex;
  int touchedIndex2;

  List<Global> globalInfo = [];
  List<TableOperators> tableInfo = [];
  bool _loading;

  void getGlobal() async {
    ApiServices apiOne = ApiServices();
    await apiOne.getGlobal();
    globalInfo = apiOne.globalInfo;
    APIChartService apiTwo = APIChartService();
    await apiTwo.getOperatorsTable();
    tableInfo = apiTwo.tableOperators;

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;

    super.initState();
    getGlobal();

    _tabChartController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    // Use media query to provude us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: size.height,
              width: size.width,
              //decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/ido_background.png"), fit: BoxFit.fill)),
              child: FluidLayout(
                  child: Builder(
                      builder: (context) => CustomScrollView(slivers: <Widget>[
                            makeAppBar(context, searchController),
                            SliverToBoxAdapter(child: HeadingTitle()),
                            SliverFluidGrid(
                              fluid: true,
                              spacing: 30,
                              children: [
                                if (context.breakpoint.isLargerThanS)
                                  FluidCell.fit(
                                      size: context.fluid(12, xs: 12, s: 12, m: 12),
                                      child: HiddenCustomCard(
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                        Text(
                                          globalInfo[0].delegatorsCount.toString() + ' Delegations',
                                          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                        ),
                                        Text(
                                          globalInfo[0].validatorsCount.toString() + ' Validators',
                                          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                        ),
                                        Text(
                                          'IDO Start Date',
                                          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                        ),
                                        Text(DateTime.fromMicrosecondsSinceEpoch(int.parse(globalInfo[0].start.toString()) * 1000).toString().substring(0, 10)),
                                        Text(
                                          'IDO End Date',
                                          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                        ),
                                        Text(DateTime.fromMicrosecondsSinceEpoch(int.parse(globalInfo[0].stop.toString()) * 1000).toString().substring(0, 10)),
                                      ]))),
                                if (context.breakpoint.isSmallerThanM)
                                  FluidCell.fit(
                                      size: context.fluid(12, xs: 12, s: 12, m: 12),
                                      child: HiddenCustomCard(
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                        Text(
                                          globalInfo[0].delegatorsCount.toString() + ' Delegations',
                                          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                        ),
                                        Text(
                                          globalInfo[0].validatorsCount.toString() + ' Validators',
                                          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                        ),
                                      ]))),
                                if (context.breakpoint.isSmallerThanM)
                                  FluidCell.fit(
                                      size: context.fluid(12, xs: 12, s: 12, m: 12),
                                      child: HiddenCustomCard(
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                        Text(
                                          'IDO Start Date',
                                          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                        ),
                                        Text(DateTime.fromMicrosecondsSinceEpoch(int.parse(globalInfo[0].start.toString()) * 1000).toString().substring(0, 10)),
                                        Text(
                                          'IDO End Date',
                                          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                        ),
                                        Text(DateTime.fromMicrosecondsSinceEpoch(int.parse(globalInfo[0].stop.toString()) * 1000).toString().substring(0, 10)),
                                      ]))),
                                FluidCell.withFixedHeight(
                                  size: context.fluid(9, xs: 12, s: 12, m: 9, l: 9, xl: 9),
                                  height: 320,
                                  child: Scaffold(
                                    drawerScrimColor: Colors.white,
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
                                    body: TabBarView(
                                      physics: NeverScrollableScrollPhysics(),
                                      controller: _tabChartController,
                                      children: [
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[DelegationsChart()],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[IncomeChart()],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[MiningChart()],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (context.breakpoint.isLargerThanS)
                                  FluidCell.fit(
                                      size: context.fluid(3, xs: 3, s: 3, m: 3, l: 3, xl: 3),
                                      child: HiddenCustomCard(
                                          child: Column(
                                        children: [
                                          Text(
                                            'Token prices to mine KEK',
                                            style: TextStyle(fontSize: 18, color: Colors.black),
                                          ),
                                          ListTile(
                                              title: Text('COSMOS'),
                                              subtitle: Text('\$ 1.40'),
                                              dense: false,
                                              leading: CircleAvatar(
                                                child: Image.network('https://s2.coinmarketcap.com/static/img/coins/200x200/3794.png'),
                                              )),
                                          ListTile(
                                            title: Text('KIRA (KEK)'),
                                            subtitle: Text('\$ 1.40'),
                                            dense: false,
                                            leading: CircleAvatar(
                                              child: Image.network(
                                                'https://pbs.twimg.com/profile_images/1267754825476907010/yFy0NuTQ.jpg',
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text('Dfinity (DFN)'),
                                            subtitle: Text('\$ 1.40'),
                                            dense: false,
                                            leading: CircleAvatar(
                                              child: Image.network(
                                                'https://assets.coingecko.com/coins/images/3326/large/Webp.net-resizeimage_%288%29.png?1547037927',
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text('Sentinel (SENT)'),
                                            subtitle: Text('\$ 1.40'),
                                            dense: false,
                                            leading: CircleAvatar(
                                              child: Image.network(
                                                'https://miro.medium.com/max/2732/1*WdfKTlUzprd7c221Qy3q2w.png',
                                              ),
                                            ),
                                          )
                                        ],
                                      ))),
                                if (context.breakpoint.isSmallerThanM)
                                  FluidCell.fit(
                                      size: context.fluid(12),
                                      child: HiddenCustomCard(
                                          child: Row(
                                        children: [
                                          CircleAvatar(
                                            child: Image.network('https://s2.coinmarketcap.com/static/img/coins/200x200/3794.png'),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [Text('Cosmos'), Text('\$ 1.40')],
                                          ),
                                          Spacer(),
                                          CircleAvatar(
                                            child: Image.network('https://pbs.twimg.com/profile_images/1267754825476907010/yFy0NuTQ.jpg'),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [Text('KIRA'), Text('\$ 1.40')],
                                          ),
                                          Spacer(),
                                          CircleAvatar(
                                            child: Image.network('https://assets.coingecko.com/coins/images/3326/large/Webp.net-resizeimage_%288%29.png?1547037927'),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [Text('Dfinity (DFN)'), Text('\$ 1.40')],
                                          ),
                                          Spacer(),
                                          CircleAvatar(
                                            child: Image.network('https://miro.medium.com/max/2732/1*WdfKTlUzprd7c221Qy3q2w.png'),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [Text('Sentinel (SENT)'), Text('\$ 1.40')],
                                          ),
                                          Spacer(),
                                        ],
                                      ))),
                                FluidCell.fit(
                                    size: context.fluid(6, xs: 12, s: 12, m: 12),
                                    child: CustomCard(
                                        child: Column(children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Mining & Hashrate Stats',
                                            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 18, color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                        thickness: 0.1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 100,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Total Mined'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(globalInfo[0].minedTotal.toString()),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Text('Max Supply'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(globalInfo[0].mintingSupply.toString()),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  child: SizedBox(
                                                    height: 100,
                                                    width: 100,
                                                    child: PieChart(
                                                      PieChartData(
                                                          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                                            setState(() {
                                                              if (pieTouchResponse.touchInput is FlLongPressEnd || pieTouchResponse.touchInput is FlPanEnd) {
                                                                touchedIndex = -1;
                                                              } else {
                                                                touchedIndex = pieTouchResponse.touchedSectionIndex;
                                                              }
                                                            });
                                                          }),
                                                          borderData: FlBorderData(
                                                            show: false,
                                                          ),
                                                          sectionsSpace: 10,
                                                          centerSpaceRadius: 10,
                                                          sections: showMiningStats()),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: 130,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Mining Hashrate'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(globalInfo[0].hashrate.toStringAsFixed(2) + " per year"),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Text('Funding Hashrate'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(('\$' + (globalInfo[0].hashrate * globalInfo[0].price).toStringAsFixed(2))),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]))),
                                FluidCell.fit(
                                    size: context.fluid(6, xs: 12, s: 12, m: 12),
                                    child: CustomCard(
                                        child: Column(children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Funds Stats',
                                            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 18, color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                        thickness: 0.1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Total fundraised'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('\$' + globalInfo[0].totalIncome.toStringAsFixed(2)),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Text('Total value of all  \n fundraised delegated'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('\$' + globalInfo[0].delegationsValue.toStringAsFixed(2)),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                    child: SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: PieChart(
                                                    PieChartData(
                                                        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                                          setState(() {
                                                            if (pieTouchResponse.touchInput is FlLongPressEnd || pieTouchResponse.touchInput is FlPanEnd) {
                                                              touchedIndex2 = -1;
                                                            } else {
                                                              touchedIndex2 = pieTouchResponse.touchedSectionIndex;
                                                            }
                                                          });
                                                        }),
                                                        borderData: FlBorderData(
                                                          show: false,
                                                        ),
                                                        sectionsSpace: 10,
                                                        centerSpaceRadius: 10,
                                                        sections: showingFundingStats()),
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ]))),
                                /*
                                FluidCell.fit(
                                    size: context.fluid(2, xs: 12, s: 12, m: 12),
                                    child: CustomCard(
                                        child: Column(children: [
                                      Text(
                                        'Total Delegations',
                                        style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                        thickness: 0.1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Text(globalInfo[0].delegatorsCount.toString()),
                                      ),
                                      Text(
                                        'Total Validators',
                                        style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                        thickness: 0.1,
                                      ),
                                      Text(globalInfo[0].validatorsCount.toString()),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          'IDO Start Date',
                                          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                        thickness: 0.1,
                                      ),
                                      Text(DateTime.fromMicrosecondsSinceEpoch(int.parse(globalInfo[0].start.toString()) * 1000).toString().substring(0, 10)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          'IDO End Date',
                                          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                        thickness: 0.1,
                                      ),
                                      Text(DateTime.fromMicrosecondsSinceEpoch(int.parse(globalInfo[0].stop.toString()) * 1000).toString().substring(0, 10)),
                                    ]))),
                                    */
                                FluidCell.withFixedHeight(
                                  size: context.fluid(12, xs: 12, s: 12, m: 12),
                                  height: 250,
                                  child: Scaffold(
                                    backgroundColor: Colors.white,
                                    drawerScrimColor: Colors.white,
                                    body: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Center(
                                          child: Container(
                                            child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: IdoDataTable(tableInfo)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]))),
            ),
    );
  }

  SliverToBoxAdapter makeAppBar(BuildContext context, TextEditingController searchController) {
    return SliverToBoxAdapter(
        child: FluidCell.fit(
            size: context.fluid(12),
            child: CustomCard(
                color: Colors.white,
                child: Container(
                  child: CustomAppBar(),
                ))));
  }

  Padding overViewRow({leadingtext, endingText}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        children: [
          Text(
            leadingtext,
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.grey[500])),
          ),
          Spacer(),
          Text(
            endingText,
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.grey[500])),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingFundingStats() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex2;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.deepPurple,
            value: 60,
            title: '60%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.grey[100],
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.black),
          );

        default:
          return null;
      }
    });
  }

  List<PieChartSectionData> showMiningStats() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.deepPurple,
            //globalInfo[0].minedTotal == 0 ? 100 :  ((10000/globalInfo[0].mintingSupply)*100).toDouble()
            value: globalInfo[0].minedTotal == 0 || globalInfo[0].minedTotal == null ? 0 : ((globalInfo[0].minedTotal / globalInfo[0].mintingSupply) * 100).toStringAsFixed(0),
            title: globalInfo[0].minedTotal == 0 || globalInfo[0].minedTotal == null ? '0%' : ((globalInfo[0].minedTotal / globalInfo[0].mintingSupply) * 100).toStringAsFixed(0) + '%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.grey[100],
            value: globalInfo[0].minedTotal == 0 || globalInfo[0].minedTotal == null ? 100 : ((100 - (globalInfo[0].minedTotal / globalInfo[0].mintingSupply) * 100)).toStringAsFixed(0),
            title: globalInfo[0].minedTotal == 0 || globalInfo[0].minedTotal == null ? '100%' : ((100 - (14989622900000 / globalInfo[0].mintingSupply) * 100)).toStringAsFixed(0) + '%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.black),
          );

        default:
          return null;
      }
    });
  }
}
