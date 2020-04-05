import 'package:flutter/material.dart';

class MostInfectedState extends StatelessWidget {
  final Map<String, dynamic> stateDetails;
  MostInfectedState({this.stateDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25.0),
        // border: Border.all(color: Colors.red.shade100, width: 1),
      ),
      width: 160.0,
      height: 220.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: Center(
                child: Text(
                  stateDetails['state'],
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown.shade800,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
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
                          color: Colors.green.shade600,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Flexible(
                        child: Text(
                          stateDetails['confirmed'],
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.green.shade700,
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
                          color: Colors.red.shade600,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Flexible(
                        child: Text(
                          stateDetails['deaths'],
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.red.shade700,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ),
                    ],
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
