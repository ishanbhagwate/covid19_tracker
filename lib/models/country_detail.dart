class CountryDetail {
  Map<String, dynamic> countryInfo;
  String cases;
  String country;
  String todayCases;
  String deaths;
  String todayDeaths;
  String recovered;
  String active;
  String critical;
  String casesPerOneMillion;
  String deathsPerOneMillion;
  int updated;

  CountryDetail(result) {
    this.country = result['country'].toString();
    this.cases = result['cases'].toString();
    this.todayCases = result['todayCases'].toString();
    this.countryInfo = result['countryInfo'];
    this.deaths = result['deaths'].toString();
    this.todayDeaths = result['todayDeaths'].toString();
    this.recovered = result['recovered'].toString();
    this.active = result['active'].toString();
    this.critical = result['critical'].toString();
    this.casesPerOneMillion = result['casesPerOneMillion'].toString();
    this.deathsPerOneMillion = result['deathsPerOneMillion'].toString();
    this.updated = result['updated'];
  }
}
