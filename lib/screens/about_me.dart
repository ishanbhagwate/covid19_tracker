import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    _launchURL(String link) async {
      if (await canLaunch(link)) {
        await launch(link);
      } else {
        throw 'Could not launch $link';
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      'About me',
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
            child: Container(
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/profile.svg',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      height: screenWidth * 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 8.0,
                        right: 8.0,
                        bottom: 8.0,
                      ),
                      child: Text(
                        'Ishan Bhagwate',
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Ubuntu',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        bottom: 10.0,
                        top: 10.0,
                      ),
                      child: Text(
                        'Android Developer | Flutter Developer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Ubuntu',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        left: 25.0,
                        right: 25.0,
                      ),
                      child: SizedBox(
                        height: 1.0,
                        child: Container(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        bottom: 10.0,
                        top: 10.0,
                      ),
                      child: Text(
                        'Follow me on',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Color(0xFF3167A8),
                          wordSpacing: 2,
                          fontFamily: 'Ubuntu',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 10.0,
                        top: 5.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  'https://www.instagram.com/the.notorious.beast/');
                            },
                            child: SvgPicture.asset(
                              'assets/icons/instagram.svg',
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              height: screenWidth * 0.15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  'https://www.linkedin.com/in/ishan-bhagwate/');
                            },
                            child: SvgPicture.asset(
                              'assets/icons/linkedin.svg',
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              height: screenWidth * 0.15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchURL('https://twitter.com/b2x_codes');
                            },
                            child: SvgPicture.asset(
                              'assets/icons/twitter.svg',
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              height: screenWidth * 0.15,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
