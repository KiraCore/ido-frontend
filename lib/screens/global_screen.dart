import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ido_explorer/data/services.dart';
import 'package:ido_explorer/models/global.dart';
import 'package:ido_explorer/screens/widgets/custom_appbar.dart';
import 'package:ido_explorer/screens/widgets/custom_card.dart';
import 'package:ido_explorer/screens/widgets/heading_title.dart';
import 'package:ido_explorer/screens/widgets/ido_datatable.dart';
import 'package:ido_explorer/screens/widgets/personal_holding_datatable.dart';

class GlobalScreen extends StatefulWidget {
  @override
  _GlobalScreenState createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> with TickerProviderStateMixin {
  TabController _tabChartController;

  List<Global> globalInfo = [];
  bool _loading;

  void getGlobal() async {
    ApiServices apiOne = ApiServices();
    await apiOne.getGlobal();
    globalInfo = apiOne.globalInfo;

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
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/ido_background.png"), fit: BoxFit.fill)),
              child: FluidLayout(
                  child: Builder(
                      builder: (context) => CustomScrollView(slivers: <Widget>[
                            makeAppBar(context),
                            SliverToBoxAdapter(child: HeadingTitle()),
                            SliverFluidGrid(
                              fluid: true,
                              spacing: 10,
                              children: [
                                FluidCell.withFixedHeight(
                                  size: context.fluid(12, xs: 12, s: 12, m: 12, l: 6, xl: 6),
                                  height: 250,
                                  child: Scaffold(
                                    backgroundColor: Color.fromRGBO(42, 3, 76, 1),
                                    drawerScrimColor: Colors.white,
                                    appBar: TabBar(
                                        labelColor: Colors.white,
                                        indicatorColor: Colors.deepPurple,
                                        controller: _tabChartController,
                                        tabs: [
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
                                      controller: _tabChartController,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Delegations Chart',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Center(
                                          child: Text('Funds Comittted Chart',
                                              style: TextStyle(color: Colors.white)),
                                        ),
                                        Center(
                                          child: Text('Mined Chart',
                                              style: TextStyle(color: Colors.white)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                FluidCell.withFixedHeight(
                                  size: context.fluid(12, xs: 12, s: 12, m: 12, l: 6, xl: 6),
                                  height: 250,
                                  child: CustomCard(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: PersonalHoldings(),
                                    ),
                                  ),
                                ),
                                FluidCell.withFixedHeight(
                                    size: context.fluid(5, xs: 12, s: 12, m: 7),
                                    height: 280,
                                    child: CustomCard(
                                        child: Column(children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Mining & Hashrate Stats',
                                            style: GoogleFonts.sourceSansPro(
                                                textStyle:
                                                    TextStyle(fontSize: 18, color: Colors.black)),
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
                                                  color: Colors.red,
                                                  child: SizedBox(
                                                    height: 100,
                                                    width: 100,
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
                                                  Text(globalInfo[0].hashrate.toString() +
                                                      " per year "),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Text('Funding Hashrate'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      (globalInfo[0].hashrate * globalInfo[0].price)
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]))),
                                FluidCell.withFixedHeight(
                                    size: context.fluid(4, xs: 12, s: 12, m: 5),
                                    height: 280,
                                    child: CustomCard(
                                        child: Column(children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Funds Stats',
                                            style: GoogleFonts.sourceSansPro(
                                                textStyle:
                                                    TextStyle(fontSize: 18, color: Colors.black)),
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
                                                  Text('Funds delegated'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('PlaceHolder'),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Text('Total Raised'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('PlaceHolder'),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                    color: Colors.red,
                                                    child: SizedBox(
                                                      height: 100,
                                                      width: 100,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ]))),
                                FluidCell.fit(
                                    size: context.fluid(3, xs: 12, s: 12, m: 12),
                                    child: CustomCard(
                                        child: Column(children: [
                                      Row(
                                        children: [
                                          Text('Total Delegations'),
                                          Spacer(),
                                          Text(globalInfo[0].delegatorsCount.toString())
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                        thickness: 0.1,
                                      ),
                                      Row(
                                        children: [
                                          Text('Total Validators'),
                                          Spacer(),
                                          Text(globalInfo[0].validatorsCount.toString()),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                        thickness: 0.1,
                                      ),
                                      Row(
                                        children: [
                                          Text('IDO Start Date'),
                                          Spacer(),
                                          Text(globalInfo[0].start.toString()),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                        thickness: 0.1,
                                      ),
                                      Row(
                                        children: [
                                          Text('IDO End Date'),
                                          Spacer(),
                                          Text(globalInfo[0].stop.toString()),
                                        ],
                                      ),
                                    ]))),
                                FluidCell.withFixedHeight(
                                  size: context.fluid(12, xs: 12, s: 12, m: 12),
                                  height: 250,
                                  child: Scaffold(
                                    backgroundColor: Colors.white,
                                    drawerScrimColor: Colors.white,
                                    body: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: IdoDataTable()),
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

  SliverToBoxAdapter makeAppBar(BuildContext context) {
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
            style: GoogleFonts.sourceSansPro(
                textStyle: TextStyle(fontSize: 15, color: Colors.grey[500])),
          ),
          Spacer(),
          Text(
            endingText,
            style: GoogleFonts.sourceSansPro(
                textStyle:
                    TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}
