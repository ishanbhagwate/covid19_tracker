import 'package:flutter/material.dart';

class ChangeCountryPopupDialog extends StatefulWidget {
  final BuildContext context;
  final List<String> countries;

  ChangeCountryPopupDialog({this.countries, this.context});

  @override
  _ChangeCountryPopupDialogState createState() =>
      _ChangeCountryPopupDialogState();
}

class _ChangeCountryPopupDialogState extends State<ChangeCountryPopupDialog> {
  String _currentSelectedCountry;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        elevation: 5.0,
        contentPadding: EdgeInsets.all(10.0),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                    items: widget.countries.map((String val) {
                      return DropdownMenuItem(
                        child: Text(val),
                        value: val,
                      );
                    }).toList(),
                    onChanged: (String newVal) {
                      setState(() {
                        _currentSelectedCountry = newVal;
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
                        Navigator.of(context, rootNavigator: true)
                            .pop(_currentSelectedCountry);
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
                height: 8.0,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    // color: Color(0xFF79CB61),
                    padding: EdgeInsets.symmetric(
                      vertical: 13.0,
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
