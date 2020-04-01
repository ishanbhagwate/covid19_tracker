import 'package:covid_19_tracker/models/country_detail.dart';
import 'package:flutter/material.dart';

class MostInfectedCountries extends StatefulWidget {
  final int index;
  final CountryDetail countryDetail;
  final String countryCode;
  MostInfectedCountries({this.index, this.countryDetail, this.countryCode});

  @override
  _MostInfectedCountriesState createState() => _MostInfectedCountriesState();
}

class _MostInfectedCountriesState extends State<MostInfectedCountries> {
  Color _currentColorLight, _currentColorDark;
  String countryCode;

  @override
  void initState() {
    super.initState();
    countryCode = widget.countryCode;
    switch (widget.index) {
      case 0:
        _currentColorLight = Colors.grey;
        _currentColorDark = Colors.grey.shade700;
        break;
      case 1:
        _currentColorLight = Colors.orange.shade400;
        _currentColorDark = Colors.orange.shade800;
        break;
      case 2:
        _currentColorLight = Colors.blue.shade400;
        _currentColorDark = Colors.blue.shade700;
        break;
      case 3:
        _currentColorLight = Colors.green.shade400;
        _currentColorDark = Colors.green.shade700;
        break;
      case 4:
        _currentColorLight = Colors.brown.shade400;
        _currentColorDark = Colors.brown.shade700;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _currentColorDark,
            _currentColorLight,
          ],
        ),
      ),
      width: 160.0,
      height: 220.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                    widget.countryDetail.country,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Infected',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    widget.countryDetail.cases,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Deaths',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    widget.countryDetail.deaths,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
