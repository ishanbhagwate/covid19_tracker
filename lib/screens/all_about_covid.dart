import 'package:covid_19_tracker/models/faqs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transparent_image/transparent_image.dart';

class AllAboutCovid extends StatefulWidget {
  @override
  _AllAboutCovidState createState() => _AllAboutCovidState();
}

class _AllAboutCovidState extends State<AllAboutCovid> {
  List<Faqs> faqs;

  @override
  void initState() {
    super.initState();
    faqs = faqList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.99),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50.0),
              bottomLeft: Radius.circular(50.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 250.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    height: 250.0,
                    padding: EdgeInsets.all(20.0),
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
                  ),
                  Hero(
                    child: SvgPicture.asset(
                      'assets/images/nurse.svg',
                      height: 220.0,
                      fit: BoxFit.contain,
                    ),
                    tag: 'TOP',
                  ),
                  Positioned(
                    right: 10.0,
                    bottom: 30.0,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      'Get to know about Covid-19',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    top: 0,
                    child: SafeArea(
                      child: BackButton(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              addAutomaticKeepAlives: true,
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'Symptoms',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      Text(
                        '(Source: WHO)',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue.shade900,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 170.0,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 20.0,
                      );
                    },
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: false,
                    addAutomaticKeepAlives: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print('Send to details');
                        },
                        child: buildSymptomContainer(index),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'Prevention',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      Text(
                        '(Source: WHO)',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue.shade900,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  height: 180.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        spreadRadius: 8.0,
                        offset: Offset(0, 2),
                        color: Colors.black.withOpacity(0.01),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(23.0),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/wash_hands.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Wash hands',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Regularly and thoroughly clean your hands with an alcohol-based hand rub or wash them with soap and water.',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 14.0,
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  height: 180.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        spreadRadius: 8.0,
                        offset: Offset(0, 2),
                        color: Colors.black.withOpacity(0.01),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Social distancing',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Maintain at least 1 metre (3 feet) distance between yourself and anyone who is coughing or sneezing.',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 14.0,
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(23.0),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/social_distance.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  height: 180.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        spreadRadius: 8.0,
                        offset: Offset(0, 2),
                        color: Colors.black.withOpacity(0.01),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.brown.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(23.0),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/relax_home.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Stay home',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Relax if you feel unwell. This will also protect you and help prevent spread of viruses and other infections.',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 14.0,
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  height: 180.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        spreadRadius: 8.0,
                        offset: Offset(0, 2),
                        color: Colors.black.withOpacity(0.01),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Seek doctor',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'If you have a fever, cough and difficulty breathing, seek medical attention and call in advance. Follow the directions of your local health authority.',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 14.0,
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(23.0),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/seek_doctor.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  height: 180.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        spreadRadius: 8.0,
                        offset: Offset(0, 2),
                        color: Colors.black.withOpacity(0.01),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(23.0),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/work_remotely.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Work remotely',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'If possible, avoid traveling and ask your employer to give WFH - especially if you are an older person or have diabetes, heart or lung disease.',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 14.0,
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'FAQ\'s',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      Text(
                        '(Source: WHO)',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue.shade900,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(23.0),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/faq.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                allFaq(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget allFaq() {
    return ListView.builder(
      addAutomaticKeepAlives: true,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: faqs.length,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      itemBuilder: (context, index) => ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            faqs[index].question,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.75),
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              faqs[index].answer,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.7),
                fontFamily: 'Ubuntu',
                letterSpacing: 0.7,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSymptomContainer(int index) {
    String imageAsset;
    String symptomName;

    switch (index) {
      case 0:
        imageAsset = 'assets/images/fever_red.png';
        symptomName = 'Fever';
        break;
      case 1:
        imageAsset = 'assets/images/body_pain_red.png';
        symptomName = 'Tiredness';
        break;
      case 2:
        imageAsset = 'assets/images/cough_red.png';
        symptomName = 'Dry cough';
        break;
      case 3:
        imageAsset = 'assets/images/running_nose_red.png';
        symptomName = 'Running nose';
        break;
      case 4:
        imageAsset = 'assets/images/head_ache_red.png';
        symptomName = 'Aches/Pains';
        break;

      default:
    }

    return Container(
      height: 150.0,
      width: 150.0,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Colors.blue.shade100, width: 0.5),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            height: 100.0,
            child: Image.asset(
              imageAsset,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Text(
              symptomName,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
