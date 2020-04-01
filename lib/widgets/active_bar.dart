import 'package:covid_19_tracker/models/country_detail.dart';
import 'package:flutter/material.dart';

class ActiveColorBar extends StatelessWidget {
  final CountryDetail countryDetail;
  final Color activeColor;
  final Color bgColor;
  final double activeColorWidth;
  ActiveColorBar({
    this.countryDetail,
    this.activeColor,
    this.activeColorWidth,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: activeColorWidth,
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: activeColor,
      ),
    );
  }
}
