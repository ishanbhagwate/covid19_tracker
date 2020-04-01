import 'package:flutter/material.dart';

class AllCountriesShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.15),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenWidth * 0.3,
            height: 22.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.2,
                    height: 22.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: screenWidth * 0.15,
                    height: 14.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.2,
                    height: 22.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: screenWidth * 0.15,
                    height: 14.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.2,
                    height: 22.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: screenWidth * 0.15,
                    height: 14.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
