import 'package:IDO_Kira/models/kira_model.dart';
import 'package:IDO_Kira/models/ticker_priceModel.dart';
import 'package:IDO_Kira/models/validator_table_model.dart';
import 'package:IDO_Kira/services/chart_service.dart';
import 'package:IDO_Kira/services/info_service.dart';
import 'package:IDO_Kira/widgets/bottom_tokenpanel.dart';
import 'package:IDO_Kira/widgets/custom_appbar.dart';
import 'package:IDO_Kira/widgets/custom_card.dart';
import 'package:IDO_Kira/widgets/heading_banner.dart';
import 'package:IDO_Kira/widgets/ido_chart.dart';
import 'package:IDO_Kira/widgets/kira_footer.dart';
import 'package:IDO_Kira/widgets/side_tokenpanel.dart';
import 'package:IDO_Kira/widgets/validator_widget_table.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';

class KiraScreen extends StatefulWidget {
  @override
  _KiraScreenState createState() => _KiraScreenState();
}

class _KiraScreenState extends State<KiraScreen> with TickerProviderStateMixin {
  TabController _tabChartController;
  int touchedIndex;
  int touchedIndex2;
  List<ValidatorTableModel> validatorInfo = [];
  List<KiraModel> kiraInfo = [];
  List<TickerPriceModel> tickerInfo = [];
  bool _loading;

  void getKiraInfomation() async {
    InfoService kiraAPI = InfoService();
    await kiraAPI.getKiraInfo();
    kiraInfo = kiraAPI.kiraInfo;

    ChartService chartAPI = ChartService();
    await chartAPI.getValidatorTable();
    validatorInfo = chartAPI.validatorTable;

    setState(() {
      _loading = false;
    });
  }

  void getTokenInformation() async {
    InfoService tickerAPI = InfoService();
    await tickerAPI.getTickerInfo();
    tickerInfo = tickerAPI.tickerInfo;
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    getKiraInfomation();
    getTokenInformation();
    _tabChartController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    // Get the size and width of our user's screen
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: size.height,
                width: size.width,
                //  set a background image here decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/ido_background.png"), fit: BoxFit.fill)),
                child: FluidLayout(
                  child: Builder(
                    builder: (BuildContext context) => CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(child: CustomAppBar()),

                        //Silver(context),
                        HeadingBanner(),
                        SliverFluidGrid(
                          fluid: true,
                          spacing: 30,
                          children: [
                            FluidCell.withFixedHeight(size: context.fluid(9, xs: 12, s: 12, m: 9, l: 9, xl: 9), height: 320, child: IdoChart(tabChartController: _tabChartController)),
                            if (context.breakpoint.isLargerThanS) FluidCell.fit(size: context.fluid(3, xs: 3, s: 3, m: 3, l: 3, xl: 3), child: SideTokensPanel(tickerInfo: tickerInfo)),
                            if (context.breakpoint.isSmallerThanM)
                              FluidCell.fit(
                                  size: context.fluid(12, xs: 12, s: 12, m: 12, l: 12, xl: 12),
                                  child: BottomTokenPanel(
                                    tickerInfo: tickerInfo,
                                  )),
                            FluidCell.fit(size: context.fluid(6, xs: 12, s: 12, m: 12), child: showMiningHashrateStats()),
                            FluidCell.fit(size: context.fluid(6, xs: 12, s: 12, m: 12), child: showFundsStats()),
                            FluidCell.withFixedHeight(
                              size: context.fluid(12, xs: 12, s: 12, m: 12),
                              height: 400,
                              child: ValidatorTable(tableInfo: validatorInfo),
                            ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: KiraFooter(),
                        ),

                        // Only Sliver widgets can exist here. This is an array of such widgets
                      ],
                    ),
                  ),
                ),
              ));
  }

  CustomCard showMiningHashrateStats() {
    return CustomCard(
        child: Column(children: [
      Row(
        children: [
          Text(
            'Mining & Hashrate Stats',
            //style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 18, color: Colors.black)),
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
                  (kiraInfo[0].minedTotal.toString() == "null") ? Text('0') : Text(kiraInfo[0].minedTotal.toString()),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Max Supply'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(kiraInfo[0].mintingSupply.toString()),
                ],
              ),
            ),
            Flexible(
              child: Column(
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
                  Text(kiraInfo[0].hashrate.toStringAsFixed(2) + " per year"),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Funding Hashrate'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(('\$' + (kiraInfo[0].hashrate * kiraInfo[0].price).toStringAsFixed(2))),
                ],
              ),
            ),
          ],
        ),
      )
    ]));
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
            //kiraInfo[0].minedTotal == 0 ? 100 :  ((10000/kiraInfo[0].mintingSupply)*100).toDouble()
            value: kiraInfo[0].minedTotal == 0 || kiraInfo[0].minedTotal == null ? 0 : ((kiraInfo[0].minedTotal / kiraInfo[0].mintingSupply) * 100).toStringAsFixed(0),
            title: kiraInfo[0].minedTotal == 0 || kiraInfo[0].minedTotal == null ? '0%' : ((kiraInfo[0].minedTotal / kiraInfo[0].mintingSupply) * 100).toStringAsFixed(0) + '%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.grey[100],
            value: kiraInfo[0].minedTotal == 0 || kiraInfo[0].minedTotal == null ? 100 : ((100 - (kiraInfo[0].minedTotal / kiraInfo[0].mintingSupply) * 100)).toStringAsFixed(0),
            title: kiraInfo[0].minedTotal == 0 || kiraInfo[0].minedTotal == null ? '100%' : ((100 - (14989622900000 / kiraInfo[0].mintingSupply) * 100)).toStringAsFixed(0) + '%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.black),
          );

        default:
          return null;
      }
    });
  }

  CustomCard showFundsStats() {
    return CustomCard(
        child: Column(children: [
      Row(
        children: [
          Text(
            'Funds Stats',
            //style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 18, color: Colors.black)),
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
                  Text('\$' + kiraInfo[0].totalIncome.toStringAsFixed(2)),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Total value of all  \n fundraised delegated'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('\$' + kiraInfo[0].delegationsValue.toStringAsFixed(2)),
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
    ]));
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
            value: 100 - ((kiraInfo[0].totalIncome / kiraInfo[0].delegationsValue) * 100),
            title: (100 - ((kiraInfo[0].totalIncome / kiraInfo[0].delegationsValue) * 100)).toStringAsFixed(1) + "%",
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.grey[100],
            value: (kiraInfo[0].totalIncome / kiraInfo[0].delegationsValue) * 100,
            title: ((kiraInfo[0].totalIncome / kiraInfo[0].delegationsValue) * 100).toStringAsFixed(1) + "%",
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.black),
          );

        default:
          return null;
      }
    });
  }
}
