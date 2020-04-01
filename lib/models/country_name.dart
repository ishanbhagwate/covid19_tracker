class Country {
  final String name;
  final String code;

  Country({this.name, this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return new Country(
      name: json['name'] as String,
      code: json['code'] as String,
    );
  }
}
