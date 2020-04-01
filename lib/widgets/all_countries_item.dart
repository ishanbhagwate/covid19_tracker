import 'package:covid_19_tracker/models/country_detail.dart';
import 'package:flutter/material.dart';

class AllCountriesItem extends StatelessWidget {
  final CountryDetail countryDetail;
  final String countryCode;

  AllCountriesItem({this.countryDetail, this.countryCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            spreadRadius: 8.0,
            offset: Offset(0, 2),
            color: Colors.black.withOpacity(0.01),
          ),
        ],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Image.network(countryDetail.countryInfo['flag']),
              Image.asset(
                'icons/flags/png/$countryCode.png',
                package: 'country_icons',
                height: 18.0,
                fit: BoxFit.fill,
                width: 26.0,
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  countryDetail.country,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ],
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
                  Text(
                    countryDetail.cases,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Infected',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    countryDetail.deaths,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Deaths',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    countryDetail.recovered,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade400,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Recovered',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontFamily: 'Ubuntu',
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
