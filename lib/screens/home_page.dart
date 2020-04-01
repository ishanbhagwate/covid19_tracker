import 'package:covid_19_tracker/screens/about.dart';
import 'package:covid_19_tracker/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'my_country.dart';

class HomePage extends StatefulWidget {
  // final double screenWidth;
  // HomePage(this.screenWidth);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();
  int _selectedIndex;

  var currentPage, currentTitle, currentColor;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            Dashboard(),
            MyCountry(screenWidth),
            About(),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: BottomAppBar(
          elevation: 20.0,
          child: Container(
            height: 70.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _pageController.jumpToPage(0);
                      _selectedIndex = 0;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.whatshot,
                        size: _selectedIndex == 0 ? 30.0 : 25.0,
                        color:
                            _selectedIndex == 0 ? Colors.blue : Colors.black54,
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                          color: _selectedIndex == 0
                              ? Colors.blue
                              : Colors.black54,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _pageController.jumpToPage(1);
                      _selectedIndex = 1;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.map,
                        size: _selectedIndex == 1 ? 30.0 : 25.0,
                        color:
                            _selectedIndex == 1 ? Colors.blue : Colors.black54,
                      ),
                      Text(
                        'My Country',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                          color: _selectedIndex == 1
                              ? Colors.blue
                              : Colors.black54,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _pageController.jumpToPage(2);
                      _selectedIndex = 2;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: _selectedIndex == 2 ? 30.0 : 25.0,
                        color:
                            _selectedIndex == 2 ? Colors.blue : Colors.black54,
                      ),
                      Text(
                        'About',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                          color: _selectedIndex == 2
                              ? Colors.blue
                              : Colors.black54,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
