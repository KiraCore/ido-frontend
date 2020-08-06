import 'package:flutter/material.dart';

class HeadingBanner extends StatelessWidget {
  const HeadingBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          color: Colors.grey[200],
          child: SizedBox(
            height: 40,
            width: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*  
                Text(
                  'KIRA - Interchain Mining Event',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                */
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
