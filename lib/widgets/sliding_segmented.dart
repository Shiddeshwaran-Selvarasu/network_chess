import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingSegmentedControl extends StatefulWidget {
  const SlidingSegmentedControl({Key? key,required this.myTabs,required this.selectIndex,required this.onValueChanged}) : super(key: key);

  final Map<int, Widget> myTabs;
  final int selectIndex;
  final Function(int?) onValueChanged;

  @override
  State<SlidingSegmentedControl> createState() => _SlidingSegmentedControlState();
}

class _SlidingSegmentedControlState extends State<SlidingSegmentedControl> {
  int segmentedControlGroupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: CupertinoSlidingSegmentedControl(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            groupValue: widget.selectIndex,
            children: widget.myTabs,
            onValueChanged: widget.onValueChanged,
          ),
        ),
      ),
    );
  }
}

