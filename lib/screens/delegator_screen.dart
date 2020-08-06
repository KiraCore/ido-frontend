import 'package:IDO_Kira/models/delegator_model.dart';
import 'package:IDO_Kira/models/delegator_validator_table_model.dart';
import 'package:IDO_Kira/services/chart_service.dart';
import 'package:IDO_Kira/services/info_service.dart';
import 'package:IDO_Kira/widgets/custom_appbar.dart';
import 'package:IDO_Kira/widgets/custom_card.dart';
import 'package:IDO_Kira/widgets/delegator_delegation_chart.dart';
import 'package:IDO_Kira/widgets/delegator_income_chart.dart';
import 'package:IDO_Kira/widgets/delegator_mining_chart.dart';
import 'package:IDO_Kira/widgets/delegator_validator_widget_table%20copy.dart';
import 'package:IDO_Kira/widgets/heading_banner.dart';
import 'package:IDO_Kira/widgets/hidden_card.dart';
import 'package:IDO_Kira/widgets/kira_footer.dart';
import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_alert/status_alert.dart';

class DelegatorScreen extends StatefulWidget {
  final String address;
  DelegatorScreen({this.address}) {
    assert(address != null || !address.contains(null), 'Delegator screen is provided null or empty address');
  }

  @override
  _DelegatorScreenState createState() => _DelegatorScreenState();
}

class _DelegatorScreenState extends State<DelegatorScreen> with TickerProviderStateMixin {
  TabController _tabChartController;

  List<DelegatorModel> delegatorInfo = [];
  List<DelegatorValidatorTableModel> validatorInfo = [];

  bool _loading;

  @override
  void initState() {
    _loading = true;
    super.initState();
    _tabChartController = TabController(vsync: this, length: 3);
    getDelegatorInfo();
  }

  void statusAlertScreen() {
    return StatusAlert.show(context, duration: Duration(seconds: 50), title: 'Failed to connect and fetch data', subtitle: 'Check internet connection and try again', configuration: IconConfiguration(icon: Icons.sms_failed));
  }

  void getDelegatorInfo() async {
    try {
      InfoService delegatorAPI = InfoService();
      await delegatorAPI.getDelegatorInfo(address: widget.address);
      delegatorInfo = delegatorAPI.delegatorInfo;
      ChartService validatorAPI = ChartService();
      await validatorAPI.getDelegatorValidatorTable(address: widget.address);
      validatorInfo = validatorAPI.delegatorValidatorTable;
    } catch (e) {
      statusAlertScreen();
      print('getDelegatorInfo: Failed to Retrieve Delegator Information : Exception: ' + e);
    }

    setState(() {
      _loading = false;
    });
  }

  void getValidatorInfo() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: FluidLayout(
                  child: Builder(
                    builder: (BuildContext context) => CustomScrollView(
                      slivers: <Widget>[
                        //SilverAppBar(context),
                        SliverToBoxAdapter(child: CustomAppBar()),

                        HeadingBanner(),
                        SliverFluidGrid(
                          fluid: true,
                          spacing: 30,
                          children: [
                            FluidCell.fit(
                                size: context.fluid(12, xs: 12, s: 12, m: 12),
                                child: HiddenCustomCard(
                                    child: Column(children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Address ' + delegatorInfo[0].kiraAddress,
                                        style: GoogleFonts.robotoSlab(textStyle: TextStyle(fontSize: 20, color: Colors.black)),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: IconButton(
                                          icon: Icon(Icons.content_copy),
                                          onPressed: () {},
                                        ),
                                      )
                                    ],
                                  )
                                ]))),
                            FluidCell.fit(size: context.fluid(12, xs: 12, s: 12, m: 12, l: 6, xl: 6), child: buildCharts()),
                            FluidCell.withFixedHeight(
                              size: context.fluid(12, xs: 12, s: 12, m: 12, l: 6, xl: 6),
                              height: 250,
                              child: buildTabBar(),
                            ),
                            FluidCell.withFixedHeight(
                              size: context.fluid(12, xs: 12, s: 12, m: 12, l: 12, xl: 12),
                              height: 400,
                              child: DelegatorValidatorTable(
                                tableInfo: validatorInfo,
                              ),
                            ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: KiraFooter(),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }

  Scaffold buildTabBar() {
    return Scaffold(
      drawerScrimColor: Colors.white,
      appBar: TabBar(labelColor: Colors.black, indicatorColor: Colors.deepPurple, controller: _tabChartController, tabs: [
        Tab(
          child: Text(
            'Delegations Value ',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Tab(
          child: Text(
            '\$ Mining Report',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Tab(
          child: Text(
            'Validator Income Report',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ]),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabChartController,
        children: [
          Container(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
              DelegatorDelegationChart(
                address: widget.address,
              ),
            ]),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DelegatorMiningChart(
                  address: widget.address,
                )
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DelegatorIncomeChart(
                  address: widget.address,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  CustomCard buildCharts() {
    return CustomCard(
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
          Text('Balance :', style: TextStyle(fontSize: 16, color: Colors.black)),
          Spacer(),
          //Text(delegatorInfo[0].delegations.toString() + ' (' + delegatorInfo[0].delegationsValue.toString() + ')'),
        ],
      ),
      Row(
        children: [
          Text('undelegations:', style: TextStyle(fontSize: 13, color: Colors.grey[500])),
          Spacer(),
          Text(delegatorInfo[0].undelegations.toString(), style: TextStyle(fontSize: 13, color: Colors.grey[500]))
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text('Mined total :', style: TextStyle(fontSize: 16, color: Colors.black)),
          Spacer(),
          Text(delegatorInfo[0].minedTotal.toString() + '(\$' + (delegatorInfo[0].minedTotal * delegatorInfo[0].priceQuote).toStringAsFixed(2) + ')'),
        ],
      ),
      Row(
        children: [
          Text('claimed Total :', style: TextStyle(fontSize: 13, color: Colors.grey[500])),
          Spacer(),
          (delegatorInfo[0].claimedTotal.toString() == "null") ? Text('0', style: TextStyle(fontSize: 13, color: Colors.grey[500])) : Text(delegatorInfo[0].claimedTotal.toString(), style: TextStyle(fontSize: 13, color: Colors.grey[500]))
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text('Hash rate :', style: TextStyle(fontSize: 16, color: Colors.black)),
          Spacer(),
          Text(delegatorInfo[0].hashrate.toString() + '(\$' + (delegatorInfo[0].hashrate * delegatorInfo[0].priceQuote).toStringAsFixed(2) + ')'),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text('Network:', style: TextStyle(fontSize: 16, color: Colors.black)),
          Spacer(),
          Text(delegatorInfo[0].network.toString())
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text('Cosmos Address:', style: TextStyle(fontSize: 16, color: Colors.black)),
          Spacer(),
          Flexible(child: Text(delegatorInfo[0].delegatorAddress.toString()))
        ],
      ),
    ]));
  }
}
