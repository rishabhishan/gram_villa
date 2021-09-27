import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Constants.dart';

class BottomNavBar extends StatefulWidget {
  final List<BottomNavItem> items;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  int selectedIndex;
  final ValueChanged<int> onTabSelected;

  BottomNavBar(
      {key,
        required this.items,
        this.height: 56.0,
        this.iconSize: 24.0,
        this.backgroundColor: Colors.white,
        this.color: Colors.black12,
        this.selectedColor: kActiveIconColor,
        required this.onTabSelected,
        this.selectedIndex: 0})
      : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    _updateIndex(int index) {
      widget.onTabSelected(index);
      setState(() {
        widget.selectedIndex = index;
      });
    }

    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
        color: Colors.transparent,
        //clipBehavior: Clip.hardEdge,
        child: Container(
            height: widget.height,
            decoration: BoxDecoration(
//                borderRadius: BorderRadius.only(
//                    topLeft: Radius.circular(circularBorderRadius),
//                    topRight: Radius.circular(circularBorderRadius)),
                boxShadow: [

                ] ,
                color: Colors.white),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: items)));
  }

  Widget _buildTabItem({
    required BottomNavItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    if(index==2){
      return
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ClipOval(
            child: Material(
              //elevation: 18,
              color: kAccentColor, // button color
              child: InkWell(
                child: SizedBox(width: 32, height: 32, child: Icon(Icons.add, color: Colors.white,)),
                onTap:  item.press(),
              ),
            ),
          ),
        )
      ;
    }

    Color color =
    widget.selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: Container(
//        margin: EdgeInsets.only(
//            right: index == 1 ? 20 : 0, left: index == 2 ? 20 : 0),
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Container(
                padding: widget.selectedIndex == index?EdgeInsets.all(16):EdgeInsets.all(17),
                //color: Color(0xff89ceea),
                child: widget.selectedIndex == index ?SvgPicture.asset(item.iconLocation, color: color):SvgPicture.asset(item.iconLocation, color: color,)),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String iconLocation;
  Function press = (){};
  final int index;
  final int activeIndex;

  BottomNavItem({required this.icon ,required this.iconLocation,  required this.press,  this.index = 0, this.activeIndex = 0});
}
