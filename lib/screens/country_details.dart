import 'package:covid_19_tracker/models/country_detail.dart';
import 'package:covid_19_tracker/widgets/active_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' show Client;

class CountryDetails extends StatefulWidget {
  final CountryDetail countryDetail;
  final double width;
  final CountryDetail mainDetails;
  CountryDetails({this.countryDetail, this.width, this.mainDetails});

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  int totalCases,
      activeCases,
      recoveredCases,
      criticalCases,
      todaysCases,
      todaysDeaths,
      deaths,
      deathsPerMill,
      casesPerMil;

  String countryIso3;
  String mortalityRate, mortalityRateGlobal;

  double activeCasesColorWidth,
      recoveredCasesColorWidth,
      criticalCasesColorWidth;

  double screenWidth;
  Client client = Client();

  // Map<String, dynamic> _countryHistoricalMap;

  @override
  void initState() {
    super.initState();

    screenWidth = widget.width;

    countryIso3 = widget.countryDetail.countryInfo['iso3'];
    totalCases = int.parse(widget.countryDetail.cases);
    activeCases = int.parse(widget.countryDetail.active);
    recoveredCases = int.parse(widget.countryDetail.recovered);
    criticalCases = int.parse(widget.countryDetail.critical);
    todaysCases = int.parse(widget.countryDetail.todayCases);
    todaysDeaths = int.parse(widget.countryDetail.todayDeaths);
    deaths = int.parse(widget.countryDetail.deaths);
    if (widget.countryDetail.casesPerOneMillion != 'null') {
      casesPerMil = int.parse(
        double.parse(widget.countryDetail.casesPerOneMillion)
            .round()
            .toString(),
      );
    } else {
      casesPerMil = 0;
    }

    if (widget.countryDetail.deathsPerOneMillion != 'null') {
      deathsPerMill = int.parse(
        double.parse(widget.countryDetail.deathsPerOneMillion)
            .round()
            .toString(),
      );
    } else {
      deathsPerMill = 0;
    }

    var globalDeaths = int.parse(widget.mainDetails.deaths);
    var globalCases = int.parse(widget.mainDetails.cases);

    mortalityRate = (deaths / totalCases * 100).toStringAsFixed(1);
    mortalityRateGlobal = (globalDeaths / globalCases * 100).toStringAsFixed(1);

    double activePer = activeCases / totalCases * 100;
    double recoveredPer = recoveredCases / totalCases * 100;
    double criticalPer = criticalCases / totalCases * 100;

    // print(activePer);
    // print(recoveredPer);
    // print(criticalPer);

    activeCasesColorWidth = (screenWidth - 40.0) * (activePer / 100);
    recoveredCasesColorWidth = (screenWidth - 40.0) * (recoveredPer / 100);
    criticalCasesColorWidth = (screenWidth - 40.0) * (criticalPer / 100);

    // print(activeCasesColorWidth);
    // print(recoveredCasesColorWidth);
    // print(criticalCasesColorWidth);
  }

  // Future getHistoricalData() async {
  //   final response = await client
  //       .get('https://corona.lmao.ninja/v2/historical/$countryIso3');

  //   if (response.statusCode == 200) {
  //     var parsedJson = json.decode(response.body);

  //     _countryHistoricalMap = parsedJson;
  //   } else {
  //     throw Exception('Failed to get historical data');
  //   }

  //   print(_countryHistoricalMap);

  //   return _countryHistoricalMap;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.blue.shade900,
                ],
              ),
              color: Colors.blue.shade600,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    BackButton(
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: Text(
                        widget.countryDetail.country,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 60.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.globeAmericas,
                            size: 22.0,
                            color: Colors.blue.shade800,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'Total Cases',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ],
                      ),
                      Text(
                        totalCases.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange.shade900,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange.shade900,
                                    ),
                                    width: 10.0,
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Active Cases',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                activeCases.toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 40.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color:
                                      Colors.orange.shade900.withOpacity(0.1),
                                ),
                              ),
                              ActiveColorBar(
                                activeColor: Colors.orange.shade900,
                                bgColor:
                                    Colors.orange.shade900.withOpacity(0.5),
                                countryDetail: widget.countryDetail,
                                activeColorWidth: activeCasesColorWidth,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.pink.shade500,
                                    ),
                                    width: 10.0,
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Recovered Cases',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                recoveredCases.toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 40.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.pink.withOpacity(0.1),
                                ),
                              ),
                              ActiveColorBar(
                                activeColor: Colors.pink.shade500,
                                bgColor: Colors.pink.shade900.withOpacity(0.5),
                                countryDetail: widget.countryDetail,
                                activeColorWidth: recoveredCasesColorWidth,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.shade900,
                                    ),
                                    width: 10.0,
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Critical Cases',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                criticalCases.toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 40.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.red.shade900.withOpacity(0.1),
                                ),
                              ),
                              ActiveColorBar(
                                activeColor: Colors.red.shade900,
                                bgColor: Colors.red.shade900.withOpacity(0.5),
                                countryDetail: widget.countryDetail,
                                activeColorWidth: criticalCasesColorWidth,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green.withOpacity(0.15),
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.skullCrossbones,
                                color: Colors.red.shade700,
                                size: 13.0,
                              ),
                              width: 25.0,
                              height: 25.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Death\'s',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              todaysDeaths.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade800,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              deaths.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade800,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.lime.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Mortality Rate \n(approx)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Global',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              '$mortalityRateGlobal%',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade800,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              widget.countryDetail.country,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              '$mortalityRate%',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade800,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Per One Million',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Cases',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              casesPerMil.toString(),
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.orange.shade900,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Death\'s',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              deathsPerMill.toString(),
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade800,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
