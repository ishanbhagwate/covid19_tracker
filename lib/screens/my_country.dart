import 'dart:convert';
import 'package:covid_19_tracker/widgets/active_bar.dart';
import 'package:covid_19_tracker/widgets/change_country_popup.dart';
import 'package:covid_19_tracker/widgets/most_infected_countries_shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' show Client;
import 'package:covid_19_tracker/models/countries_list.dart';
import 'package:covid_19_tracker/models/country_detail.dart';
import 'package:covid_19_tracker/models/country_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/my_country_shimmer.dart';
import '../widgets/most_affected_states.dart';
import 'all_states.dart';

class MyCountry extends StatefulWidget {
  final double screenWidth;

  MyCountry(this.screenWidth);

  @override
  _MyCountryState createState() => _MyCountryState();
}

class _MyCountryState extends State<MyCountry>
    with AutomaticKeepAliveClientMixin {
  SharedPreferences prefs;
  bool firstLoad;
  String _currentSelectedCountry, _currentSelectedCountryCode;
  List<String> _countries = [];
  List<Country> countries;
  Client client = Client();
  CountryDetail countryDetail;

  List statesList;

  String countryNew;

  List countryJson;

  bool isLoading;
  bool isProceeding;
  bool changeCountry;

  String mortalityRate, mortalityRateGlobal;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future _loadingFuture;
  Future _allStatesFuture;

  CountriesList countriesList = CountriesList();

  Future _countryDetailsFuture;
  int totalCases,
      activeCases,
      recoveredCases,
      criticalCases,
      todaysCases,
      todaysDeaths,
      deaths,
      deathsPerMill,
      casesPerMil;

  double activeCasesColorWidth,
      recoveredCasesColorWidth,
      criticalCasesColorWidth;

  double screenWidth;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    isProceeding = false;
    changeCountry = false;

    screenWidth = widget.screenWidth;

    _loadingFuture = checkIfFirstLoad(false);
  }

  refreshPage() {
    print('refresh');
    setState(() {
      _loadingFuture = checkIfFirstLoad(true);
    });
  }

  Future checkIfFirstLoad(bool isProceed) async {
    prefs = await SharedPreferences.getInstance();
    getCountrieList();

    if (isProceed) {
      for (var item in countryJson) {
        if (_currentSelectedCountry == item['name']) {
          _currentSelectedCountryCode = item['code'];
          break;
        }
      }

      print(_currentSelectedCountryCode);

      prefs.setString('countryCode', _currentSelectedCountryCode);

      final response = await client.get(
          'https://corona.lmao.ninja/v2/countries/$_currentSelectedCountryCode');

      if (response.statusCode == 200) {
        var temp = json.decode(response.body);
        countryDetail = CountryDetail(temp);
        print(countryDetail);
      } else {
        print('country data not available');
        showPopupNoDataAvailable();
        return 0;
      }

      print(countryDetail.active);

      if (_currentSelectedCountryCode == 'IN') {
        getStatesData();
      }

      try {
        totalCases = int.parse(countryDetail.cases);
        activeCases = int.parse(countryDetail.active);
        recoveredCases = int.parse(countryDetail.recovered);
        criticalCases = int.parse(countryDetail.critical);
        todaysCases = int.parse(countryDetail.todayCases);
        todaysDeaths = int.parse(countryDetail.todayDeaths);
        deaths = int.parse(countryDetail.deaths);

        mortalityRate = (deaths / totalCases * 100).toStringAsFixed(1);

        if (countryDetail.casesPerOneMillion != 'null') {
          casesPerMil = int.parse(
            double.parse(countryDetail.casesPerOneMillion).round().toString(),
          );
        } else {
          casesPerMil = 0;
        }

        if (countryDetail.deathsPerOneMillion != 'null') {
          deathsPerMill = int.parse(
            double.parse(countryDetail.deathsPerOneMillion).round().toString(),
          );
        } else {
          deathsPerMill = 0;
        }

        double activePer = activeCases / totalCases * 100;
        double recoveredPer = recoveredCases / totalCases * 100;
        double criticalPer = criticalCases / totalCases * 100;

        activeCasesColorWidth = (screenWidth - 40.0) * (activePer / 100);
        recoveredCasesColorWidth = (screenWidth - 40.0) * (recoveredPer / 100);
        criticalCasesColorWidth = (screenWidth - 40.0) * (criticalPer / 100);
      } catch (e) {
        print(e);
        return 'Error occurred';
      }

      print(countryDetail.active);

      return countryDetail;
    } else {
      if (prefs.getString('countryCode') == null) {
        print('No Country Code Saved');
        //no country code saved previously
        //return 0 to show country select screen
        return 0;
      } else {
        print('Country code is saved');
        _currentSelectedCountryCode = prefs.getString('countryCode');

        if (_currentSelectedCountryCode == null) {
          //show country select
          return 0;
        } else if (_currentSelectedCountryCode != null) {
          for (var item in countryJson) {
            if (_currentSelectedCountry == item['name']) {
              _currentSelectedCountryCode = item['code'];
              break;
            }
          }

          print(_currentSelectedCountryCode);

          prefs.setString('countryCode', _currentSelectedCountryCode);

          final response = await client.get(
              'https://corona.lmao.ninja/v2/countries/$_currentSelectedCountryCode');

          if (response.statusCode == 200) {
            var temp = json.decode(response.body);
            countryDetail = CountryDetail(temp);
            print(countryDetail);
          } else {
            print('country data not available');
            showPopupNoDataAvailable();
            return 0;
          }

          print(countryDetail.active);

          if (_currentSelectedCountryCode == 'IN') {
            getStatesData();
          }

          try {
            totalCases = int.parse(countryDetail.cases);
            activeCases = int.parse(countryDetail.active);
            recoveredCases = int.parse(countryDetail.recovered);
            criticalCases = int.parse(countryDetail.critical);
            todaysCases = int.parse(countryDetail.todayCases);
            todaysDeaths = int.parse(countryDetail.todayDeaths);
            deaths = int.parse(countryDetail.deaths);
            mortalityRate = (deaths / totalCases * 100).toStringAsFixed(1);

            if (countryDetail.casesPerOneMillion != 'null') {
              casesPerMil = int.parse(
                double.parse(countryDetail.casesPerOneMillion)
                    .round()
                    .toString(),
              );
            } else {
              casesPerMil = 0;
            }

            if (countryDetail.deathsPerOneMillion != 'null') {
              deathsPerMill = int.parse(
                double.parse(countryDetail.deathsPerOneMillion)
                    .round()
                    .toString(),
              );
            } else {
              deathsPerMill = 0;
            }

            double activePer = activeCases / totalCases * 100;
            double recoveredPer = recoveredCases / totalCases * 100;
            double criticalPer = criticalCases / totalCases * 100;

            activeCasesColorWidth = (screenWidth - 40.0) * (activePer / 100);
            recoveredCasesColorWidth =
                (screenWidth - 40.0) * (recoveredPer / 100);
            criticalCasesColorWidth =
                (screenWidth - 40.0) * (criticalPer / 100);
          } catch (e) {
            print(e);
            return 'Error occurred';
          }

          print(countryDetail.active);
        } else {
          final response = await client.get(
              'https://corona.lmao.ninja/v2/countries/$_currentSelectedCountryCode');

          if (response.statusCode == 200) {
            var temp = json.decode(response.body);
            countryDetail = CountryDetail(temp);
            print(countryDetail);
          } else {
            print('country data not available');
            showPopupNoDataAvailable();
            return 0;
          }

          print(countryDetail.active);

          if (_currentSelectedCountryCode == 'IN') {
            getStatesData();
          }

          try {
            totalCases = int.parse(countryDetail.cases);
            activeCases = int.parse(countryDetail.active);
            recoveredCases = int.parse(countryDetail.recovered);
            criticalCases = int.parse(countryDetail.critical);
            todaysCases = int.parse(countryDetail.todayCases);
            todaysDeaths = int.parse(countryDetail.todayDeaths);
            deaths = int.parse(countryDetail.deaths);
            mortalityRate = (deaths / totalCases * 100).toStringAsFixed(1);

            if (countryDetail.casesPerOneMillion != 'null') {
              casesPerMil = int.parse(
                double.parse(countryDetail.casesPerOneMillion)
                    .round()
                    .toString(),
              );
            } else {
              casesPerMil = 0;
            }

            if (countryDetail.deathsPerOneMillion != 'null') {
              deathsPerMill = int.parse(
                double.parse(countryDetail.deathsPerOneMillion)
                    .round()
                    .toString(),
              );
            } else {
              deathsPerMill = 0;
            }

            double activePer = activeCases / totalCases * 100;
            double recoveredPer = recoveredCases / totalCases * 100;
            double criticalPer = criticalCases / totalCases * 100;

            activeCasesColorWidth = (screenWidth - 40.0) * (activePer / 100);
            recoveredCasesColorWidth =
                (screenWidth - 40.0) * (recoveredPer / 100);
            criticalCasesColorWidth =
                (screenWidth - 40.0) * (criticalPer / 100);
          } catch (e) {
            print(e);
            return 'Error occurred';
          }

          print(countryDetail.active);
        }

        return countryDetail;
      }
    }
  }

  Future getCountryCode(double screenWidth) async {
    if (_currentSelectedCountry != null &&
        _currentSelectedCountryCode == null) {
      for (var item in countryJson) {
        if (_currentSelectedCountry == item['name']) {
          _currentSelectedCountryCode = item['code'];
          break;
        }
      }

      print(_currentSelectedCountryCode);

      prefs.setString('countryCode', _currentSelectedCountryCode);

      _countryDetailsFuture = await getCountryDetails(screenWidth);
    } else {
      _countryDetailsFuture = await getCountryDetails(screenWidth);
    }

    return _countryDetailsFuture;
  }

  Future getCountryDetails(double screenWidth) async {
    final response = await client.get(
        'https://corona.lmao.ninja/v2/countries/$_currentSelectedCountryCode');

    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      countryDetail = CountryDetail(temp);
      print(countryDetail);
    } else {
      print('country data not available');
      showPopupNoDataAvailable();
      return 0;
    }

    print(countryDetail.active);

    if (_currentSelectedCountryCode == 'IN') {
      getStatesData();
    }

    try {
      totalCases = int.parse(countryDetail.cases);
      activeCases = int.parse(countryDetail.active);
      recoveredCases = int.parse(countryDetail.recovered);
      criticalCases = int.parse(countryDetail.critical);
      todaysCases = int.parse(countryDetail.todayCases);
      todaysDeaths = int.parse(countryDetail.todayDeaths);
      deaths = int.parse(countryDetail.deaths);
      mortalityRate = (deaths / totalCases * 100).toStringAsFixed(1);

      if (countryDetail.casesPerOneMillion != 'null') {
        casesPerMil = int.parse(
          double.parse(countryDetail.casesPerOneMillion).round().toString(),
        );
      } else {
        casesPerMil = 0;
      }

      if (countryDetail.deathsPerOneMillion != 'null') {
        deathsPerMill = int.parse(
          double.parse(countryDetail.deathsPerOneMillion).round().toString(),
        );
      } else {
        deathsPerMill = 0;
      }

      double activePer = activeCases / totalCases * 100;
      double recoveredPer = recoveredCases / totalCases * 100;
      double criticalPer = criticalCases / totalCases * 100;

      activeCasesColorWidth = (screenWidth - 40.0) * (activePer / 100);
      recoveredCasesColorWidth = (screenWidth - 40.0) * (recoveredPer / 100);
      criticalCasesColorWidth = (screenWidth - 40.0) * (criticalPer / 100);
    } catch (e) {
      print(e);
      return 'Error occurred';
    }

    print(countryDetail.active);

    return countryDetail;
  }

  getStatesData() {
    _allStatesFuture = getAllStatesData();
  }

  Future getAllStatesData() async {
    // final stateResponse = await client
    //     .get('https://api.covid19india.org/v2/state_district_wise.json');
    final stateResponse =
        await client.get('https://api.covid19india.org/data.json');

    if (stateResponse.statusCode == 200) {
      var temp = json.decode(stateResponse.body);

      statesList = temp['statewise'];

      statesList.removeAt(0);
    } else {
      print('state data not available');
      showPopupNoDataAvailable();
      return 0;
    }

    return statesList;
  }

  getCountrieList() {
    countryJson = countriesList.getCountriesList();

    _countries = [];

    for (var item in countryJson) {
      _countries.add(item['name']);
    }
  }

  changeCountryPopupDialog() async {
    var changed = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ChangeCountryPopupDialog(
          countries: _countries,
          context: context,
        );
      },
    );

    if (changed != null) {
      //changed
      print('changed:: $changed');
      _currentSelectedCountry = changed;
      refreshPage();
    }
  }

  showPopupNoDataAvailable() {
    showDialog(
      useRootNavigator: true,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        elevation: 5.0,
        contentPadding: EdgeInsets.all(10.0),
        content: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Data not available for your selected country',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            child: Container(
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
              ),
              child: SafeArea(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          'My Country',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ],
                    ),
                    // IconButton(
                    //   padding: EdgeInsets.only(right: 10.0),
                    //   icon: Icon(
                    //     Icons.refresh,
                    //     color: Colors.white,
                    //     size: 25.0,
                    //   ),
                    //   onPressed: refreshPage,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: _loadingFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                  child: Shimmer.fromColors(
                    period: Duration(milliseconds: 800),
                    baseColor: Colors.grey.withOpacity(0.5),
                    highlightColor: Colors.black.withOpacity(0.5),
                    child: MyCountryShimmer(),
                  ),
                );
              } else {
                if (snapshot.data == 0) {
                  return buildCountrySelect(context);
                }
                return buildMyCountry(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildCountrySelect(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/location1.svg',
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Select your country',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontFamily: 'Ubuntu',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Select country',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              isEmpty: _currentSelectedCountry == null,
              child: DropdownButton<String>(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400,
                ),
                underline: SizedBox(
                  height: 0,
                ),
                value: _currentSelectedCountry,
                isExpanded: true,
                isDense: true,
                items: _countries.map((String val) {
                  return DropdownMenuItem(
                    child: Text(val),
                    value: val,
                  );
                }).toList(),
                onChanged: (String newVal) {
                  setState(() {
                    _currentSelectedCountry = newVal;
                    print(_currentSelectedCountry);
                  });
                },
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.55,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color(0xFF79CB61),
                padding: EdgeInsets.symmetric(
                  vertical: 13.0,
                ),
                onPressed: () {
                  if (_currentSelectedCountry != null) {
                    refreshPage();
                  }
                },
                child: Text(
                  'Proceed',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }

  Widget buildMyCountry(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: false,
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Colors.brown,
                        size: 25.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          countryDetail.country.toUpperCase(),
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                FlatButton(
                  onPressed: changeCountryPopupDialog,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  splashColor: Colors.blue.withOpacity(0.1),
                  highlightColor: Colors.blue.withOpacity(0.07),
                  child: Text(
                    'Change country',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade800,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
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
            height: 30.0,
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
                            color: Colors.orange.shade900.withOpacity(0.1),
                          ),
                        ),
                        ActiveColorBar(
                          activeColor: Colors.orange.shade900,
                          bgColor: Colors.orange.shade900.withOpacity(0.5),
                          countryDetail: countryDetail,
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
                          countryDetail: countryDetail,
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
                          countryDetail: countryDetail,
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
                color: Colors.lime.withOpacity(0.2),
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
                  SizedBox(
                    width: 20.0,
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
          _currentSelectedCountryCode == "IN"
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Most Affected States',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            splashColor: Colors.blue.withOpacity(0.1),
                            highlightColor: Colors.blue.withOpacity(0.07),
                            onPressed: () {
                              if (statesList != null) {
                                if (statesList.length > 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllStates(
                                        statesList: statesList,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue.shade700,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: _allStatesFuture,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250.0,
                            child: Shimmer.fromColors(
                              period: Duration(milliseconds: 800),
                              baseColor: Colors.grey.withOpacity(0.5),
                              highlightColor: Colors.black.withOpacity(0.5),
                              child: ListView.builder(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return MostInfectedCountriesShimmer();
                                },
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250.0,
                            child: ListView.builder(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: false,
                              addAutomaticKeepAlives: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return MostInfectedState(
                                  stateDetails: statesList[index],
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget buildStatesWidget() {
    return Text('data');
  }

  Widget buildSelectCountry(BuildContext context, bool isNotAvailable) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(20.0),
      children: <Widget>[
        SvgPicture.asset(
          'assets/images/location1.svg',
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.25,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Select your country',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontFamily: 'Ubuntu',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              labelText: 'Select country',
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            isEmpty: _currentSelectedCountry == null,
            child: DropdownButton<String>(
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w400,
              ),
              underline: SizedBox(
                height: 0,
              ),
              value: _currentSelectedCountry,
              isExpanded: true,
              isDense: true,
              items: _countries.map((String val) {
                return DropdownMenuItem(
                  child: Text(val),
                  value: val,
                );
              }).toList(),
              onChanged: (String newVal) {
                setState(() {
                  _currentSelectedCountry = newVal;
                  print(_currentSelectedCountry);
                });
              },
            ),
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color(0xFF79CB61),
              padding: EdgeInsets.symmetric(
                vertical: 13.0,
              ),
              onPressed: () {
                if (_currentSelectedCountry != null) {
                  setState(() {
                    changeCountry = true;
                  });
                  getCountryCode(MediaQuery.of(context).size.width);
                }
              },
              child: Text(
                'Proceed',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
