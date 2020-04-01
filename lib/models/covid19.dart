class Covid19 {
  List<_AllCountriesName> _allCountriesNameList;

  Covid19.allCountriesNameFromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['countries'].length);
    List<_AllCountriesName> tempList = [];
    for (var res in parsedJson['countries']) {
      _AllCountriesName allCountriesName = _AllCountriesName(res);
      tempList.add(allCountriesName);
    }
    _allCountriesNameList = tempList;
  }

  //getters
  List<_AllCountriesName> get allCountriesNameList => _allCountriesNameList;
}

class _AllCountriesName {
  String _name;
  String _iso2;
  String _iso3;

  _AllCountriesName(result) {
    _name = result['name'];
    _iso2 = result['iso2'];
    _iso3 = result['iso3'];
  }

  String get name => _name;
  String get is02 => _iso2;
  String get iso3 => _iso3;
}
