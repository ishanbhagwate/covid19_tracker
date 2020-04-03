import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Sources extends StatefulWidget {
  @override
  _SourcesState createState() => _SourcesState();
}

class _SourcesState extends State<Sources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    BackButton(color: Colors.white),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Sources',
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
          Expanded(
              child: ListView(
            shrinkWrap: false,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/source.svg',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                'Below are the resources I used to collect and show all the data on this app',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Linkify(
                text:
                    '1) WHO: https://www.who.int/emergencies/diseases/novel-coronavirus-2019',
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                linkStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade800,
                  fontFamily: 'Ubuntu',
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Linkify(
                text:
                    '2) John Hopkins University: https://coronavirus.jhu.edu/',
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                linkStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade800,
                  fontFamily: 'Ubuntu',
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Linkify(
                text:
                    '3) CDC: https://www.cdc.gov/coronavirus/2019-nCoV/index.html',
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                linkStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade800,
                  fontFamily: 'Ubuntu',
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Linkify(
                text: '3) API : https://github.com/novelcovid/api',
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                linkStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade800,
                  fontFamily: 'Ubuntu',
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Linkify(
                text: '4) API (India): https://github.com/covid19india/api',
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                linkStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade800,
                  fontFamily: 'Ubuntu',
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
