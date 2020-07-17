import 'package:flutter/material.dart';

class ModalTrigger extends StatelessWidget {
  _showModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        context: context,
        isDismissible: true,
        isScrollControlled: false,
        builder: (context) => DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
                      ),
                      height: 500,
                      width: 50,
                      child: Column(
                        children: [
                          Flexible(
                                                      child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                      "The IDO is a crowdfunding mechanism where investors place their existing tokens or assets at stake using one or many PoS networks to “interchain-mine” a new token instead of liquidating their valuable assets to acquire new, highly speculative tokens."),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                );
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => _showModalBottomSheet(context),
      child: Text('What is an IDO?'),
    );
  }
}
