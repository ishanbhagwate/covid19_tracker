import 'package:covid_19_tracker/screens/about_me.dart';
import 'package:covid_19_tracker/screens/sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with AutomaticKeepAliveClientMixin {
  String shareText, shareSubject;

  @override
  void initState() {
    super.initState();

    shareText =
        'Check out this new app which tracks all the COVID-19 information around the world.\nApp shows you complete report of all affected coutries and global status as well.\nDownload link: ishanbhagwate.com/covid19.\nGithub link: github.com/ishanbhagwate/covid19_tracker';
    shareSubject = 'COVID-19 Tracker';
  }

  Future sendToEmail() async {
    final Email email = Email(
      subject: 'Covid19 Tracker bug',
      isHTML: false,
      recipients: ['beethical95@gmail.com'],
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 25.0,
                    ),
                    Text(
                      'About',
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
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Sources()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        width: 5.0,
                      ),
                      FaIcon(
                        FontAwesomeIcons.globe,
                        size: 25.0,
                        color: Colors.indigo,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Sources',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Ubuntu',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: SizedBox(
                    height: 1.0,
                    child: Container(
                      color: Colors.black26,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Share.share(
                      shareText,
                      subject: shareSubject,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(
                        Icons.share,
                        size: 30.0,
                        color: Colors.indigo,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Share',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Ubuntu',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: SizedBox(
                    height: 1.0,
                    child: Container(
                      color: Colors.black26,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    sendToEmail();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(
                        Icons.bug_report,
                        size: 30.0,
                        color: Colors.indigo,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Report a bug',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Ubuntu',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: SizedBox(
                    height: 1.0,
                    child: Container(
                      color: Colors.black26,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutMe()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 30.0,
                        color: Colors.indigo,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'About me',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Ubuntu',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
