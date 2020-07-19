import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';
import 'package:ido_explorer/data/services.dart';
import 'package:ido_explorer/models/delegator.dart';
import 'package:ido_explorer/screens/widgets/custom_appbar.dart';
import 'package:ido_explorer/screens/widgets/custom_card.dart';
import 'package:ido_explorer/screens/widgets/heading_title.dart';
import 'package:ido_explorer/screens/widgets/ido_datatable.dart';

class DelegatorScreen extends StatefulWidget {
  final String address;
  DelegatorScreen({this.address});
  @override
  _DelegatorScreenState createState() => _DelegatorScreenState();
}

class _DelegatorScreenState extends State<DelegatorScreen> with TickerProviderStateMixin {
  TabController _tabChartController;
  TabController _tabValidatorController;
  List<Delegator> delegatorInfo = [];
  bool _loading;

  void getDelegator() async {
    ApiServices apiOne = ApiServices(address: widget.address);
    await apiOne.getDelegator();
    delegatorInfo = apiOne.delegatorInfo;

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;

    super.initState();
    //getDelegator();
    _tabChartController = TabController(vsync: this, length: 3);
    _tabValidatorController = TabController(vsync: this, length: 2);
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
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/ido_background.png"), fit: BoxFit.fill)),
              child: FluidLayout(
                  child: Builder(
                      builder: (context) => CustomScrollView(slivers: <Widget>[
                            makeAppBar(context),
                            SliverToBoxAdapter(child: HeadingTitle()),
                            SliverFluidGrid(
                              fluid: true,
                              spacing: 10,
                              children: [
                                FluidCell.fit(
                                    size: context.fluid(12, xs: 12, s: 12, m: 12),
                                    child: CustomCard(
                                        child: Column(children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(child: Text('Total mined : ' + delegatorInfo[0].minedTotal.toString() + '(' + 'MINED VALUE * PRICE' + ')')),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    delegatorInfo[0].tickerBase,
                                                    style: TextStyle(fontSize: 18, color: Colors.black),
                                                  ),
                                                  Text(
                                                    delegatorInfo[0].priceBase.toString(),
                                                    style: TextStyle(fontSize: 18, color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                                height: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    delegatorInfo[0].tickerQuote,
                                                    style: TextStyle(fontSize: 18, color: Colors.black),
                                                  ),
                                                  Text(
                                                    delegatorInfo[0].priceQuote.toStringAsFixed(2).toString(),
                                                    style: TextStyle(fontSize: 18, color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                              child: Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text('Hashrate:' + delegatorInfo[0].hashrate.toString() + ' (' + 'HASH VALUE * PRICE' + ')'),
                                          )),
                                        ],
                                      )
                                    ]))),
                                FluidCell.withFixedHeight(
                                  size: context.fluid(12, xs: 12, s: 12, m: 12, l: 6, xl: 6),
                                  height: 250,
                                  child: Scaffold(
                                    backgroundColor: Color.fromRGBO(42, 3, 76, 1),
                                    drawerScrimColor: Colors.white,
                                    appBar: TabBar(labelColor: Colors.white, indicatorColor: Colors.deepPurple, controller: _tabChartController, tabs: [
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
                                          child: Text('Funds Comittted Chart', style: TextStyle(color: Colors.white)),
                                        ),
                                        Center(
                                          child: Text('Mined Chart', style: TextStyle(color: Colors.white)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                FluidCell.withFixedHeight(
                                    size: context.fluid(12, xs: 12, s: 12, m: 12, l: 6, xl: 6),
                                    height: 250,
                                    child: CustomCard(
                                        child: Column(children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Overview',
                                            style: TextStyle(fontSize: 18, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                        thickness: 0.1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text('Total Value of Delegations :'),
                                          Spacer(),
                                          Text(delegatorInfo[0].delegations.toString() + ' (' + delegatorInfo[0].delegationsValue.toString() + ')'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Undelegations:', style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                                          Spacer(),
                                          Text(delegatorInfo[0].undelegations.toString(), style: TextStyle(fontSize: 13, color: Colors.grey[500]))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text('Validator Address:'),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text(delegatorInfo[0].validatorAddress.toString()))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [Text('Network:'), Spacer(), Text(delegatorInfo[0].network.toString())],
                                      ),
                                    ]))),
                                FluidCell.withFixedHeight(
                                  size: context.fluid(12, xs: 12, s: 12, m: 12, l: 12, xl: 12),
                                  height: 250,
                                  child: Scaffold(
                                    backgroundColor: Colors.white,
                                    drawerScrimColor: Colors.white,
                                    appBar: TabBar(controller: _tabValidatorController, indicatorColor: Colors.deepPurple, tabs: [
                                      Tab(
                                        child: Text('All Validators'),
                                      ),
                                      Tab(
                                        child: Text('Delegated Validators'),
                                      ),
                                    ]),
                                    body: TabBarView(
                                      controller: _tabValidatorController,
                                      children: [
                                        SingleChildScrollView(scrollDirection: Axis.vertical, child: IdoDataTable()),
                                        Center(child: Text('Delegated Validators Table')),
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
            style: TextStyle(fontSize: 15, color: Colors.grey[500]),
          ),
          Spacer(),
          Text(
            endingText,
            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
