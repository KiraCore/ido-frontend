import 'package:IDO_Kira/widgets/custom_appbar.dart';
import 'package:IDO_Kira/widgets/heading_banner.dart';
import 'package:IDO_Kira/widgets/kira_footer.dart';
import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Container(
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
                      FluidCell.withFixedHeight(
                          size: context.fluid(9, xs: 12, s: 12, m: 9, l: 9, xl: 9),
                          height: 320,
                          child: Shimmer(
                              duration: Duration(seconds: 3), //Default value
                              color: Colors.white, //Default value
                              enabled: true, //Default value
                              direction: ShimmerDirection.fromLTRB(),
                              child: Container())),
                      if (context.breakpoint.isLargerThanS)
                        FluidCell.fit(
                            size: context.fluid(3, xs: 3, s: 3, m: 3, l: 3, xl: 3),
                            child: Shimmer(
                                duration: Duration(seconds: 3), //Default value
                                color: Colors.black, //Default value
                                enabled: true, //Default value
                                direction: ShimmerDirection.fromLTRB(),
                                child: Container(
                                  child: SizedBox(
                                    height: 320,
                                  ),
                                ))),
                      if (context.breakpoint.isSmallerThanM)
                        FluidCell.fit(
                            size: context.fluid(12, xs: 12, s: 12, m: 12, l: 12, xl: 12),
                            child: Shimmer(
                              duration: Duration(seconds: 3), //Default value
                              color: Colors.black, //Default value
                              enabled: true, //Default value
                              direction: ShimmerDirection.fromLTRB(),
                              child: Container(
                                child: SizedBox(
                                  height: 200,
                                  width: 50,
                                ),
                              ),
                            )),
                      FluidCell.fit(
                          size: context.fluid(6, xs: 12, s: 12, m: 12),
                          child: Shimmer(
                              duration: Duration(seconds: 3), //Default value
                              color: Colors.black, //Default value
                              enabled: true, //Default value
                              direction: ShimmerDirection.fromLTRB(),
                              child: Container(
                                color: Colors.blue,
                                child: SizedBox(
                                  height: 200,
                                ),
                              ))),
                      FluidCell.fit(
                          size: context.fluid(6, xs: 12, s: 12, m: 12),
                          child: Shimmer(
                              duration: Duration(seconds: 3), //Default value
                              color: Colors.black, //Default value
                              enabled: true, //Default value
                              direction: ShimmerDirection.fromLTRB(),
                              child: Container(
                                color: Colors.blue,
                                child: SizedBox(
                                  height: 200,
                                ),
                              ))),
                      FluidCell.withFixedHeight(
                          size: context.fluid(12, xs: 12, s: 12, m: 12),
                          height: 400,
                          child: Shimmer(
                            duration: Duration(seconds: 3), //Default value
                            color: Colors.black, //Default value
                            enabled: true, //Default value
                            direction: ShimmerDirection.fromLTRB(),
                            child: Container(),
                          )),
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
        ), //Default Value
      ),
    );
  }
}
