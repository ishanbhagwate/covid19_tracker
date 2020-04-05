import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:pie_chart/pie_chart.dart';

class MainDetails extends StatefulWidget {
  final Map<String, dynamic> mainDetails;

  MainDetails({this.mainDetails});

  @override
  _MainDetailsState createState() => _MainDetailsState();
}

class _MainDetailsState extends State<MainDetails> {
  String cases, deaths, recovered, active;
  Map<String, double> pieChartData = new Map();
  Client client = Client();

  @override
  void initState() {
    super.initState();

    cases = widget.mainDetails['cases'].toString();
    deaths = widget.mainDetails['deaths'].toString();
    recovered = widget.mainDetails['recovered'].toString();
    active = widget.mainDetails['active'].toString();

    pieChartData.putIfAbsent('Active', () => double.parse(active));
    pieChartData.putIfAbsent('Deaths', () => double.parse(deaths));
    pieChartData.putIfAbsent('Recovered', () => double.parse(recovered));
  }

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
                    Text(
                      'Global Status',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.15),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 15.0,
                        color: Colors.orange.shade900,
                      ),
                      width: 25.0,
                      height: 25.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      cases,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.15),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 13.0,
                        color: Colors.red.shade700,
                      ),
                      width: 25.0,
                      height: 25.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      deaths,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.15),
                      ),
                      child: Icon(
                        Icons.favorite,
                        size: 11.0,
                        color: Colors.pink.shade400,
                      ),
                      width: 25.0,
                      height: 25.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      recovered,
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
            ),
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Covid-19',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey.shade800,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, left: 10.0, bottom: 15.0),
                      child: PieChart(
                        legendStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontFamily: 'Ubuntu',
                        ),
                        dataMap: pieChartData,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32.0,
                        chartRadius: MediaQuery.of(context).size.width / 2,
                        showChartValuesInPercentage: true,
                        showChartValues: true,
                        showChartValuesOutside: true,
                        chartValueBackgroundColor: Colors.grey[200],
                        colorList: [
                          Colors.orange.shade600,
                          Colors.red.shade900,
                          Colors.blue,
                        ],
                        showLegends: true,
                        legendPosition: LegendPosition.right,
                        decimalPlaces: 1,
                        showChartValueLabel: true,
                        initialAngle: 0,
                        chartValueStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey.shade800,
                          fontFamily: 'Ubuntu',
                        ),
                        chartType: ChartType.disc,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
